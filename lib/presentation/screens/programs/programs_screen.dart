import 'package:flutter/material.dart';
import '../../widgets/common/main_navigation.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainNavigation(
      currentIndex: -1, // Not in main navigation
      child: Scaffold(
        appBar: const MainAppBar(title: 'Programs'),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_view_week, size: 64),
              SizedBox(height: 16),
              Text(
                'Programs',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Create and manage workout programs'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // TODO: Navigate to program creation
          },
          icon: const Icon(Icons.add),
          label: const Text('Create Program'),
        ),
      ),
    );
  }
}