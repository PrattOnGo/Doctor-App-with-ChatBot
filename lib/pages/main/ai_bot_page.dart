import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthsphere/components/chat_ui/chat_bubble.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class AIBotScreen extends StatefulWidget {
  const AIBotScreen({super.key});

  @override
  State<AIBotScreen> createState() => _AIBotScreenState();
}

class _AIBotScreenState extends State<AIBotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Part A.I"),
          leading: IconButton(
            icon: Icon(Icons.chevron_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ChatBubble(
                      text: "What is this", isUser: true, date: DateTime.now()),
                  ChatBubble(text: "Hello", isUser: false, date: DateTime.now())
                ],
              ),
            ),
          ],
        ));
  }
}
