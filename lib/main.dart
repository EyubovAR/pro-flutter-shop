import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/app_theme.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация Firebase с твоими ключами
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCjosh4QaiKwUq3FQTrVZhTy3j9iPWq4UI",
      authDomain: "pro-flutter-shop.firebaseapp.com",
      projectId: "pro-flutter-shop",
      storageBucket: "pro-flutter-shop.firebasestorage.app",
      messagingSenderId: "347293428468",
      appId: "1:347293428468:web:4a41f20e331b97bb7c0ca1",
      measurementId: "G-EJSWQ4G4TF",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Flutter Shop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Приложение открывается с экрана авторизации
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/detail': (context) => const DetailScreen(),
      },
    );
  }
}