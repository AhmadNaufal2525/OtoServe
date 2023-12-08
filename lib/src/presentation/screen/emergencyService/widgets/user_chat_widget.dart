import 'package:flutter/material.dart';

class UserChatWidget extends StatelessWidget {
  final String name;
  final String text;
  final String time;

  const UserChatWidget({
    Key? key,
    required this.name,
    required this.text,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xff03BDB9),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Color(0xff3A7FD5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xff979797),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}