import 'package:flutter/material.dart';
import '../../widgets/common/main_navigation.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigation(
      currentIndex: 0,
      child: Scaffold(
        appBar: MainAppBar(title: 'Dashboard'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.dashboard, size: 64),
              SizedBox(height: 16),
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Workout overview and quick stats'),
            ],
          ),
        ),
      ),
    );
  }
}