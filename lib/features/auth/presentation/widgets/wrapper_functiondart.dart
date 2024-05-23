import 'package:budgetmate/features/auth/presentation/pages/login_page.dart';
import 'package:budgetmate/features/finance/presentation/widgets/main_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WrapperFunction extends StatelessWidget {
  const WrapperFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: Text("Error"));
      }else{
        if(snapshot.data == null)
        {
            return const LoginScreen();
        }else{
          return const MainNavigationBar();
        }
      }
      }),
    );
  }
}