import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthsphere/components/chat_ui/chat_bubble.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/message.dart';

import 'package:http/http.dart' as http;

class AIBotScreen extends StatefulWidget {
  const AIBotScreen({super.key});

  @override
  State<AIBotScreen> createState() => _AIBotScreenState();
}

class _AIBotScreenState extends State<AIBotScreen> {
  final TextEditingController promptController = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<Message> chats = [];
  bool isMessageLoading = false;
  String userId = "";
  bool loading = true;
  @override
  void initState() {
    getInitMessages();
    super.initState();
  }

  void getInitMessages() async {
    if (supabase.auth.currentUser == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    final res = await supabase.from("messages").select() as List;
    List<Message> temp = [];
    for (var ele in res) {
      temp.add(Message(
          message: ele["prompt"],
          isUser: true,
          date: DateTime.parse(ele["created_at"] ?? "")));
      temp.add(Message(
          message: ele["response"],
          isUser: false,
          date: DateTime.parse(ele["created_at"] ?? "")));
    }
    setState(() {
      chats.addAll(temp);
      loading = false;
    });
  }

  void sendMessage() async {
    if (isMessageLoading || loading) {
      return;
    }
    final message = promptController.text.trim();
    if (message.isEmpty) {
      return;
    }
    setState(() {
      chats.add(Message(message: message, isUser: true, date: DateTime.now()));
    });
    _controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    promptController.clear();
    setState(() {
      isMessageLoading = true;
      chats.add(Message(message: "", isUser: false, date: DateTime.now()));
    });
    _controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    try {
      final body =
          jsonEncode({"model": "mistral", "prompt": message, "stream": false});
      final res = await http.post(
        Uri.https("cruel-bushes-report.loca.lt", "api/generate"),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      setState(() {
        chats[chats.length - 1] = Message(
            message: decodedResponse["response"].toString().trim(),
            isUser: false,
            date: DateTime.now());
        isMessageLoading = false;
      });
      _controller.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      await supabase.from("messages").insert({
        "prompt": message,
        "response": decodedResponse["response"].toString().trim(),
        "user_id": supabase.auth.currentUser?.id
      });
    } catch (e) {
      if (context.mounted) {
        setState(() {
          chats.removeAt(chats.length - 1);
          isMessageLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Something went wrong",
          ),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Partyush A.I"),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            loading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                        controller: _controller,
                        itemCount: chats.length,
                        reverse: true,
                        itemBuilder: (context, i) {
                          final index = chats.length - 1 - i;
                          if (index == chats.length - 1 && isMessageLoading) {
                            return ChatBubble(
                              text: chats[index].message,
                              isUser: chats[index].isUser,
                              date: chats[index].date,
                              isLoading: true,
                            );
                          }
                          return ChatBubble(
                            text: chats[index].message,
                            isUser: chats[index].isUser,
                            date: chats[index].date,
                            isLoading: false,
                          );
                        }),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    enabled: !isMessageLoading && !loading,
                    controller: promptController,
                    decoration:
                        const InputDecoration(hintText: "Type anything"),
                  )),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send_rounded),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
