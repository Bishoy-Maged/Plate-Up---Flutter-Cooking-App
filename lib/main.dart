import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plate_up/sub_splash_screen.dart';
import 'package:provider/provider.dart';

import 'Provider/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //for FavoriteProvider
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MaterialApp(
        home: SubSplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


