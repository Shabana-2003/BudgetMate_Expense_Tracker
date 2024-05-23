import 'package:budgetmate/features/finance/presentation/pages/introduction/introduction_screen.dart';
import 'package:budgetmate/features/finance/presentation/widgets/main_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: Text("Error"));
      }else{
        if(snapshot.data == null)
        {
            return const IntroductionScreen();
        }else{
          return const MainNavigationBar();
        }
      }
      }),
    );
  }
}