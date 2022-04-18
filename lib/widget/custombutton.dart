

import 'package:abdar/ui/bottomnavcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:abdar/const/brandcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton (String buttonText,onPressed){
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Colors.white, fontSize: 18.sp),
      ),
      style: ElevatedButton.styleFrom(
        primary: Mycolors.deep_orange,
        elevation: 3,
      ),
    ),
  );
}