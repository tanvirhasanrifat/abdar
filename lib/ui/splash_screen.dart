import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:abdar/const/brandcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:abdar/ui/registration_screen.dart';

import 'login_screen.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState(){
    Timer(Duration(seconds: 3), ()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>LoginScreen())));
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolors.deep_orange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("abdar",style: TextStyle(fontSize: 44.sp,color: Colors.white,fontWeight: FontWeight.bold),),
              Text("e-commerce",style: TextStyle(fontSize: 30.sp,color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.h,),
              CircularProgressIndicator(color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}

