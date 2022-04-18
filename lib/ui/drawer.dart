import 'package:abdar/const/brandcolor.dart';
import 'package:abdar/ui/bottomnavcontroller.dart';
import 'package:abdar/ui/bottomnavpages/home.dart';
import 'package:abdar/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
class Drawerr extends StatefulWidget {
  const Drawerr({Key? key}) : super(key: key);

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreen: Home(),
      menuScreen: Drawer(),
      angle: -15,
      duration: Duration(milliseconds: 600),
      menuBackgroundColor: Colors.black,

    );
  }
}
class Drawer extends StatefulWidget {
  const Drawer({Key? key}) : super(key: key);

  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 50),
        children: [
          SizedBox(
            height: 80.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("assets/logo.png"),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text("Rifat"),
          Divider(color: Colors.black,
          thickness: 2),
          SizedBox(height: 50,),
          Row(children: [Icon(Icons.home),Text("Home")]),
          SizedBox(height: 20,),
          Row(children: [Icon(Icons.person),Text("Person")]),
          SizedBox(height: 20,),
          Row(children: [Icon(Icons.shopping_cart),Text("Cart")]),
          SizedBox(height: 20,),
          Row(children: [Icon(Icons.settings),Text("Settings")]),
          SizedBox(height: 20,),
          Row(children: [Icon(Icons.help_center),Text("Help Center")]),
          SizedBox(height: 20,),
          Row(
              children: [
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
              },
              icon: Icon(Icons.power_settings_new),
              )]),Text("Log out")
        ],
      ),
    );
  }
}

