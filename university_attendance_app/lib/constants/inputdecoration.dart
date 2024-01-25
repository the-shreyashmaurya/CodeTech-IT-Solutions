import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';

InputDecoration normalTextFieldDecoration(
    {required String labletext, required String hintText, Icon? suffixIcon}) {
  return InputDecoration(
    labelStyle: impNormalTextStyle,
    hintStyle: normalTextStyle,
    hintText: hintText,
    labelText: labletext,
    isDense: true,

    // Normal Border
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(31, 18, 68, 1),
        width: 1,
      ),
    ),

    // Focused Border
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(31, 18, 68, 1),
        width: 2,
      ),
    ),
  );
}

// // Suffix Icon Button
//     suffixIcon: IconButton(onPressed: (){}, icon:suffixIcon??Icon(Icons.))

InputDecoration textFieldwithsuffixIconDecoration({
  required String labletext,
  required String hintText,
  required Icon suffixIcon,
}) {
  return InputDecoration(
    labelStyle: impNormalTextStyle,
    hintStyle: normalTextStyle,
    hintText: hintText,
    labelText: labletext,
    isDense: true,

    // Normal Border
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(31, 18, 68, 1),
        width: 1,
      ),
    ),

    // Focused Border
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(31, 18, 68, 1),
        width: 2,
      ),
    ),

    // Suffix Icon
  );

}
