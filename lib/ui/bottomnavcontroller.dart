import 'package:abdar/const/brandcolor.dart';
import 'package:abdar/ui/bottomnavpages/cart.dart';
import 'package:abdar/ui/bottomnavpages/favourite.dart';
import 'package:abdar/ui/bottomnavpages/home.dart';
import 'package:abdar/ui/bottomnavpages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages = [Home(), Favourite(), Cart(), Profile()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        currentIndex: _currentIndex ,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),backgroundColor: Colors.black,label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),backgroundColor: Colors.black,label: "Favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart),backgroundColor: Colors.black,label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person),backgroundColor: Colors.black,label: "Profile"),
        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),

      body: _pages[_currentIndex],

    );
  }
}
