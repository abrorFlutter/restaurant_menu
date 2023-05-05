import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:resturant_menu/pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    initialization();
  }


  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  bool _boolenn = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _boolenn = !_boolenn;
                });
              },
              child: const Text("Animation")
          ),
          const SizedBox(height: 20,),
          BouncingWidget(
            onPressed: () {},
            duration: const Duration(milliseconds: 100),
            scaleFactor: 1.5,
            child: AnimatedOpacity(
              opacity: _boolenn? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Container(
                width: 200,height: 200,
                color: Colors.blue,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(_createRoute());
                });
              }, 
              child: const Text("NewPage"),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(pageBuilder: (context,animation,secondaryAnimation) => DetailsPage(),
      transitionsBuilder: (context,animation,secondaryAnimation,child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        
        var tween = Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
        
        return SlideTransition(position: animation.drive(tween),child: child);
      }
    );
  }
}
