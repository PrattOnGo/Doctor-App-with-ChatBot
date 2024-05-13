import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.text,
      required this.isUser,
      required this.date,
      required this.isLoading});

  final String text;
  final bool isUser;
  final DateTime date;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 15, right: isUser ? 10 : 60, left: isUser ? 60 : 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(10),
              color: isUser
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primaryContainer,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 40,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                      colors: List.filled(
                          3, Theme.of(context).colorScheme.onPrimary),
                    ),
                  )
                : Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isUser ? Colors.white : Colors.black87),
                  ),
          ),
          !isLoading
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "${date.hour}:${date.minute}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 10),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
