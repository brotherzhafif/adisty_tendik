import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/features/tendik/home_presensi/presentation/home_swipe_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adisty Tendik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B86C3)),
      ),
      home: const HomeSwipePage(),
    );
  }
}
