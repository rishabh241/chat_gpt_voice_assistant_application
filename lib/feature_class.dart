import 'package:chat_gpt/pallete.dart';
import 'package:flutter/material.dart';
class Features extends StatelessWidget {
  final Color colors;
  final String headerText;
  final String desc;

  const Features(
      {super.key,
        required this.colors,
        required this.headerText,
        required this.desc
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 35
      ),
      decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(15)
      ),
      child:Padding(
        padding: EdgeInsets.symmetric(vertical: 20).copyWith(
          left: 15
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(headerText,
                style: const TextStyle(
                  fontFamily: 'Cera-Pro',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Pallete.blackColor,

                ),
              ),
            ),
            Text(desc,
                style: const TextStyle(
                  fontFamily: 'Cera-Pro',
                  color: Pallete.blackColor,
                ),
              ),
          ],
        ),
      )
    );
  }
}
