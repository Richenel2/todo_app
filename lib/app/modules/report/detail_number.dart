import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/extensions.dart';

class DetailNumber extends StatelessWidget {
  final Color color;
  final int number;
  final String text;
  const DetailNumber(
      {Key? key, required this.color, required this.number, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.0.wp),
          child: Container(
            height: 3.0.wp,
            width: 3.0.wp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.5.wp, color: color),
              color: color.withOpacity(0.3),
            ),
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0.sp,
              ),
            ),
            SizedBox(
              height: 2.0.wp,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}
