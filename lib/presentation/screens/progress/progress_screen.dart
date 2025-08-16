import 'package:flutter/material.dart';
import '../../widgets/common/main_navigation.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigation(
      currentIndex: 3,
      child: Scaffold(
        appBar: MainAppBar(title: 'Progress'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.trending_up, size: 64),
              SizedBox(height: 16),
              Text(
                'Progress',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('View charts and analytics'),
            ],
          ),
        ),
      ),
    );
  }
}