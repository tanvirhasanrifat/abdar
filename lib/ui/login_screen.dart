import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:abdar/const/brandcolor.dart';
import 'package:abdar/ui/bottomnavcontroller.dart';
import 'package:abdar/ui/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obsecureText = true;

  signIn()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=> BottomNavController()));
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong!");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      }
      else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");}
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolors.deep_orange,
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign In",
                        style: TextStyle(fontSize: 22.sp,color: Colors.white,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.r),
                        topRight: Radius.circular(28.r),
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Welcome Buddy!",
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: Mycolors.deep_orange,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Glad to see you back.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xffBBBBBB),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 48.h,
                                width: 41.w,
                                decoration: BoxDecoration(
                                    color: Mycolors.deep_orange,
                                    borderRadius: BorderRadius.circular(12.r)
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: "enter your e-mail",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff414041),
                                    ),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                      color: Mycolors.deep_orange,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 48.h,
                                width: 41.h,
                                decoration: BoxDecoration(
                                  color: Mycolors.deep_orange,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: _obsecureText,
                                  decoration: InputDecoration(
                                      hintText: "password must be 6 characters minimum",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xff414041),
                                      ),
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        fontSize: 15.sp,
                                        color: Mycolors.deep_orange,
                                      ),
                                      suffixIcon: _obsecureText == true
                                          ? IconButton(
                                          onPressed: (){
                                            setState(() {
                                              _obsecureText = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                          ))
                                          :
                                      IconButton(onPressed: (){
                                        setState(() {
                                          _obsecureText = true;
                                        });
                                      }, icon: Icon(
                                        Icons.visibility_off,
                                        size: 20.w,
                                      ))
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: 56.h,
                            child: ElevatedButton(
                              onPressed: ()
                            {
                              signIn();

                            }, child: Text("Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp
                              ),
                            ),
                              style: ElevatedButton.styleFrom(
                                primary: Mycolors.deep_orange,
                                elevation: 5,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Center(
                            child: Wrap(
                              children: [
                                Text("Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffBBBBBB),
                                  ),),
                                GestureDetector(
                                  child: Text(" Sign up",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Mycolors.deep_orange,
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> RegistrationScreen()));
                                  },
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
