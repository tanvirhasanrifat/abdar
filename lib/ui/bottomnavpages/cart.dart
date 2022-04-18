import 'package:abdar/const/brandcolor.dart';
import 'package:abdar/widget/fetchproducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("My Cart",style: TextStyle(fontWeight: FontWeight.bold,),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        backgroundColor: Mycolors.deep_orange,
      ),
      body: SafeArea(
        child: fetchData("users-cart-items"),
    ),
    );
  }
}