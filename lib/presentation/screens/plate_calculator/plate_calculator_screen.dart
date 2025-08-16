import 'package:flutter/material.dart';
import '../../widgets/common/main_navigation.dart';

class PlateCalculatorScreen extends StatelessWidget {
  const PlateCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainNavigation(
      currentIndex: -1, // Not in main navigation
      child: Scaffold(
        appBar: const MainAppBar(title: 'Plate Calculator'),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calculate, size: 64),
              SizedBox(height: 16),
              Text(
                'Plate Calculator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Calculate barbell plate loading'),
            ],
          ),
        ),
      ),
    );
  }
}