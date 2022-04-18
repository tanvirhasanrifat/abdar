import 'package:abdar/const/brandcolor.dart';
import 'package:abdar/ui/product_details_screen.dart';
import 'package:abdar/ui/search_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async{
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-image").get();
    setState(() {
      for (int i=0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["product-img"]
        );
      }
    });
    return qn.docs;
  }
  fetchProducts()async{
    QuerySnapshot qn = await _firestoreInstance.collection("product").get();
    setState(() {
      for( int i = 0; i < qn.docs.length; i++){
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
    return qn.docs;
  }
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState(){
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
     key: _globalKey,
      drawer: Drawer(
        child: ListView(
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
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
           _globalKey.currentState!.openDrawer();
          //  ZoomDrawer.of(context)!.toggle();
            },
            icon: Icon(Icons.menu),
        ),
        title: const Text("abdar",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 5),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        backgroundColor: Mycolors.deep_orange,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.only(
                                 topLeft: Radius.circular(8),
                                 bottomLeft: Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          hintText: "Search products here",
                          hintStyle: TextStyle(fontSize: 15.sp),
                        ),
                         ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      color: Mycolors.deep_orange,
                      child: Icon(Icons.search_rounded,
                      color: Colors.white,),
                    ),
                    onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=> SearchScreen())),
                  )
                ],
              ),),
              SizedBox(height: 10.sp,),
              AspectRatio(
                  aspectRatio: 3.8,
              child: CarouselSlider(
                items:_carouselImages.map((item) => Padding(
                    padding: EdgeInsets.only(left: 3,right: 3),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item),
                      fit: BoxFit.fitWidth,
                    )
                  ),
                ),),
                ).toList() ,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (val,carouselPageChangedReason){
                    setState(() {
                      _dotPosition=val;
                    });
                  }
                ),
                  ),
              ),
              SizedBox(height: 10.h,),
              DotsIndicator(
                  dotsCount: _carouselImages.length == 0 ? 1 : _carouselImages.length,
                  position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Mycolors.deep_orange,
                  color: Mycolors.deep_orange.withOpacity(0.5),
                  spacing: EdgeInsets.all(4),
                  activeSize: Size(8,8),
                  size: Size(6,6),
                ),
              ),
              SizedBox(height: 15.h,),
             Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,childAspectRatio: 0.8,
                      ),
                      itemBuilder: (_,index){
                       return GestureDetector(
                         onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(_products[index]))),
                         child: Card(
                           elevation: 5,
                           child: Column(
                             children: [
                               AspectRatio(
                                 aspectRatio: 1.5,
                                 child: Image.network(_products[index]["product-img"][0],fit: BoxFit.fitHeight,),),
                               Text(
                             "${_products[index]["product-name"]}"
                               ),
                          Text(
                          "${_products[index]["product-price"].toString()}"
                               )
                             ],
                           ),
                         ),
                       );
                      }
                  ),
              ),



            ],
          ),

        ),

      ),
    );
  }
}
