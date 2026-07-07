import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/features/tendik/home_presensi/presentation/index.dart';
import 'package:adisty_tendik_module/core/widgets/internet_guard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      // InternetGuard membungkus semua halaman secara global
      builder: (context, child) => InternetGuard(child: child!),
      home: const HomePage(),
    );
  }
}
