import 'package:budgetmate/features/finance/data/models/finances_data.dart';
import 'package:budgetmate/features/finance/presentation/pages/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

   if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
           apiKey: "AIzaSyDbgGvVFJxNBIcuK_pRxhI1LmZCwk8Lzac",
  authDomain: "budgetmate-e8e34.firebaseapp.com",
  projectId: "budgetmate-e8e34",
  storageBucket: "budgetmate-e8e34.appspot.com",
  messagingSenderId: "402581280962",
  appId: "1:402581280962:web:95e1cb137127a0a18ac35b",
  measurementId: "G-SF7T90GMHV"
           ));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDbgGvVFJxNBIcuK_pRxhI1LmZCwk8Lzac",
      projectId: "budgetmate-e8e34",
      storageBucket: "budgetmate-e8e34.appspot.com",
      messagingSenderId: "402581280962",
      appId: "1:402581280962:web:95e1cb137127a0a18ac35b",
    ));
  }
  await FirebaseAppCheck.instance.activate(
  );

  await Hive.initFlutter();
  Hive.registerAdapter(ProfileDataAdapter());
  Hive.registerAdapter(FinancesDataAdapter());
  await Hive.openBox<FinancesData>('data');
  await Hive.openBox<FinancesData>('addDataBox');
  await Hive.openBox<ProfileData>('profileBox');

  Box<FinancesData> dataBox = Hive.box<FinancesData>('data');
  bool hasFinancialData = dataBox.isNotEmpty;


  final fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: "BKagOny0KF_2pCJQ3m....moL0ewzQ8rZu");
  print(fcmToken);
  runApp(MyApp(hasFinancialData: hasFinancialData));
}

class MyApp extends StatelessWidget {
  final bool hasFinancialData;

  const MyApp({super.key, required this.hasFinancialData});

  @override
  Widget build(BuildContext context) {
  return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    )
    );
  }
}
