import 'package:flutter/material.dart';

class CardChat extends StatelessWidget {
  final String name;
  final String text;
  final String time;
  final Color colorName;
  final Color colorContainer;

  const CardChat({
    Key? key,
    required this.name,
    required this.text,
    required this.time,
    required this.colorName,
    required this.colorContainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: colorName,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: colorContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 13),
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
          )
        ],
      ),
    );
  }
}