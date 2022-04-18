import 'package:abdar/const/brandcolor.dart';
import 'package:abdar/ui/bottomnavpages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_ageController;


  setDataToTextField(data){
    return  Column(
      children: [
        TextFormField(
          controller: _nameController = TextEditingController(text: data['name']),
        ),
        TextFormField(
          controller: _phoneController = TextEditingController(text: data['phone']),
        ),
        TextFormField(
          controller: _ageController = TextEditingController(text: data['age']),
        ),
        SizedBox(height: 20,),
        SizedBox(
          width: 1.sw,
          height: 40.h,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, updateData());
            },
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            style: ElevatedButton.styleFrom(
              primary: Mycolors.deep_orange,
              elevation: 3,
            ),
          ),
        ),
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_nameController!.text,
          "phone":_phoneController!.text,
          "age":_ageController!.text,
        }
    ).then((value) =>Fluttertoast.showToast(msg:"Updated Successfully"));
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
                onPressed: () => Navigator.pop(context),

                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      body: SafeArea(child: Padding(
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
    );
  }
}
