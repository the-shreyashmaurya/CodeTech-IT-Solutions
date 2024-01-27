import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';

class RecentSubjects extends StatelessWidget {
  const RecentSubjects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2, left: 2),
      width: 175,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(187, 141, 230, 1),
                      Color.fromRGBO(128, 75, 179, 1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Subject Name",
                    style: impNormalTextStyle,
                  ),
                  Text(
                    "Subject Code",
                    style: normalTextStyle,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
