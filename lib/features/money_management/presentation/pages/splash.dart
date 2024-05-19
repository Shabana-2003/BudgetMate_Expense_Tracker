// import 'package:budgetmate/features/money_management/presentation/pages/introduction/introduction_screen.dart';
// import 'package:flutter/material.dart';

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   double opacityLevel = 0.0; 

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         opacityLevel = 1.0;
//       });
//     });

//     Future.delayed(const Duration(seconds: 4), () {
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => IntroductionScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             const begin = Offset(0.0, 1.0);
//             const end = Offset.zero;
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOutCubic));

//             var offsetAnimation = animation.drive(tween);

//             return SlideTransition(
//               position: offsetAnimation,
//               child: FadeTransition(
//                 opacity: animation,
//                 child: child,
//               ),
//             );
//           },
//           transitionDuration: const Duration(milliseconds: 800),
//         ),
//       );
//     }
//    );
//   }


//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body:  Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
           
//             Column(
//               children: [
//                 Center(
//                   child: AnimatedOpacity(
//                     opacity: opacityLevel,
//                     duration:const Duration(seconds: 3),
//                     child: Padding(
//                       padding: const EdgeInsets.all(40.0),
//                       child: Flexible(
//                         child: Image.asset(
//                           'assets/images/budgetmate_splash_img.png',
                          
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
            
//           ],
//         ),
//       ),
//     );
  
// }
// }
import 'dart:async';
import 'package:budgetmate/features/money_management/presentation/widgets/wrapper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a long-running task such as fetching data
    Timer  (Duration(seconds: 3), () {
      // After 3 seconds, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const Wrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 243, 233),
      body: Center(
        child: Image.asset(
          'assets/images/budgetmate_splash_img.png', // replace with your image path
          width: 260,
          height: 260,
          //fit: BoxFit.contain,
        ),
      ),
    );
  }
}

