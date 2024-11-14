import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcasing/showcase_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            surface: Colors.white,
            surfaceTint: Colors.white,
            primary: Colors.orange,
            seedColor: Colors.orange),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const FoodHomePage(),
    );
  }
}
