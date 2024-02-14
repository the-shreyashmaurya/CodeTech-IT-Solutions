import 'package:flutter/material.dart';

class StudentListItemWidget extends StatelessWidget {
  final String studentId;
  const StudentListItemWidget({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [       

          // Student Name
          

          // PRN
        ],
      ),
    );
  }
}
