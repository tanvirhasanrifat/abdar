import 'package:abdar/const/brandcolor.dart';
import 'package:abdar/ui/bottomnavcontroller.dart';
import 'package:abdar/ui/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  setDataToTextField(data){
    return  Column(
      children: [
        SizedBox(
          height: 50.h,
          child: Row(
            children: [
              Text('Name:',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Text(data['name'],style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
          child: Row(
            children: [
              Text('Phone:',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
              SizedBox(width: 10,),
              Text(data['phone'],style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
          child: Row(
            children: [
              Text('Age:',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
              SizedBox(width: 10,),
              Text(data['age'],style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Mycolors.deep_orange,
            child: IconButton(
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>BottomNavController())),

                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      body: SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProfile())),
              child: Text("Edit Profile")),
          Expanded(
            flex: 1,
              child: Padding(
         padding: const EdgeInsets.all(20.0),
       child: StreamBuilder(
           stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
           builder: (BuildContext context, AsyncSnapshot snapshot){
             var data = snapshot.data;
             if(data==null){
               return Center(child: CircularProgressIndicator(),);
             }
             return setDataToTextField(data);
           },

         ),
       )),

                  ],

    ),

      ),
    );
  }
}