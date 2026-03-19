/// ========================================
/// GC OS MVP 客户端 - 主入口
/// ========================================

import 'package:flutter/material.dart';
import 'screens/connect/connect_screen.dart';

void main() {
  runApp(const GeniusClawApp());
}

class GeniusClawApp extends StatelessWidget {
  const GeniusClawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeniusClaw',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ConnectScreen(),
    );
  }
}