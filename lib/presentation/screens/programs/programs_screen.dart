import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_providers.dart';
import '../../../domain/entities/program.dart';
import '../../../domain/entities/user_program.dart';
import 'program_detail_screen.dart';
import 'providers/program_providers.dart';

class ProgramsScreen extends ConsumerStatefulWidget {
  const ProgramsScreen({super.key});

  @override
  ConsumerState<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends ConsumerState<ProgramsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedDifficulty = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Programs'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.library_books), text: 'Templates'),
              Tab(icon: Icon(Icons.person), text: 'My Programs'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTemplatesTab(),
            _buildMyProgramsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showCreateProgramDialog();
          },
          icon: const Icon(Icons.add),
          label: const Text('Create Program'),
        ),
    );
  }

  Widget _buildTemplatesTab() {
    return Column(
      children: [
        _buildSearchAndFilters(),
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final programsAsync = ref.watch(programTemplatesProvider);
              
              return programsAsync.when(
                data: (programs) {
                  final filteredPrograms = _filterPrograms(programs);
                  
                  if (filteredPrograms.isEmpty) {
                    return _buildEmptyState();
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPrograms.length,
                    itemBuilder: (context, index) {
                      return _buildProgramCard(filteredPrograms[index]);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error loading programs: $error'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMyProgramsTab() {
    return Consumer(
      builder: (context, ref, child) {
        const userId = 'demo_user'; // TODO: Get from auth
        final userProgramsAsync = ref.watch(userProgramsProvider(userId));
        
        return userProgramsAsync.when(
          data: (userPrograms) {
            if (userPrograms.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fitness_center, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No active programs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start a program from templates or create your own',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: userPrograms.length,
              itemBuilder: (context, index) {
                return _buildUserProgramCard(userPrograms[index]);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error loading programs: $error'),
          ),
        );
      },
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search bar
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search programs...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 12),
          // Difficulty filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['All', 'beginner', 'intermediate', 'advanced'].map((difficulty) {
                final isSelected = _selectedDifficulty == difficulty;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(difficulty.toUpperCase()),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedDifficulty = difficulty;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(Program program) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showProgramDetails(program),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (program.author != null)
                          Text(
                            'by ${program.author}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                  _buildDifficultyChip(program.difficulty),
                ],
              ),
              const SizedBox(height: 12),
              if (program.description != null)
                Text(
                  program.description!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.schedule,
                    '${program.frequency ?? 3} days/week',
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.calendar_today,
                    '${program.durationWeeks ?? 12} weeks',
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _startProgram(program),
                    child: const Text('START'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color chipColor;
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        chipColor = Colors.green;
        break;
      case 'intermediate':
        chipColor = Colors.orange;
        break;
      case 'advanced':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      label: Text(
        difficulty.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor.withOpacity(0.1),
      side: BorderSide(color: chipColor),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No programs found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  List<Program> _filterPrograms(List<Program> programs) {
    return programs.where((program) {
      final matchesSearch = _searchQuery.isEmpty ||
          program.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (program.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (program.author?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);

      final matchesDifficulty = _selectedDifficulty == 'All' ||
          program.difficulty == _selectedDifficulty;

      return matchesSearch && matchesDifficulty;
    }).toList();
  }

  void _showProgramDetails(Program program) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProgramDetailScreen(program: program),
      ),
    );
  }

  void _startProgram(Program program) async {
    const userId = 'demo_user'; // TODO: Get from auth
    
    try {
      await startProgram(ref, program, userId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Started ${program.name}!')),
        );
        
        // Switch to My Programs tab to show the new program
        _tabController.animateTo(1);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start program: $e')),
        );
      }
    }
  }

  Widget _buildUserProgramCard(UserProgram userProgram) {
    return Consumer(
      builder: (context, ref, child) {
        final programAsync = ref.watch(programByIdProvider(userProgram.programId));
        
        return programAsync.when(
          data: (program) {
            if (program == null) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text('Unknown Program'),
                  subtitle: Text('Program not found'),
                  trailing: Icon(Icons.error),
                ),
              );
            }
            
            return _buildUserProgramCardContent(userProgram, program);
          },
          loading: () => Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Loading...'),
              leading: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Error'),
              subtitle: Text('Failed to load program'),
              trailing: Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserProgramCardContent(UserProgram userProgram, Program program) {
    final progress = userProgram.progressPercentage(program.durationWeeks ?? 12);
    final daysSinceStart = userProgram.daysSinceStart;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showUserProgramDetails(userProgram, program),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Week ${userProgram.currentWeek}, Day ${userProgram.currentDay}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(userProgram.status),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  userProgram.isActive ? Colors.blue : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${(progress * 100).round()}% complete',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$daysSinceStart days ago',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (userProgram.isActive) ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _continueProgram(userProgram, program),
                        child: const Text('CONTINUE'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _pauseProgram(userProgram),
                      icon: const Icon(Icons.pause),
                      tooltip: 'Pause',
                    ),
                  ] else if (userProgram.isPaused) ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _resumeProgram(userProgram),
                        child: const Text('RESUME'),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: Colors.green[600], size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'COMPLETED',
                              style: TextStyle(
                                color: Colors.green[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    String displayText;
    
    switch (status.toLowerCase()) {
      case 'active':
        chipColor = Colors.green;
        displayText = 'ACTIVE';
        break;
      case 'paused':
        chipColor = Colors.orange;
        displayText = 'PAUSED';
        break;
      case 'completed':
        chipColor = Colors.blue;
        displayText = 'COMPLETED';
        break;
      default:
        chipColor = Colors.grey;
        displayText = status.toUpperCase();
    }

    return Chip(
      label: Text(
        displayText,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor.withOpacity(0.1),
      side: BorderSide(color: chipColor),
    );
  }

  void _showCreateProgramDialog() {
    // TODO: Implement program creation dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Program creation coming soon!')),
    );
  }

  void _showUserProgramDetails(UserProgram userProgram, Program program) {
    // TODO: Implement user program details screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProgramDetailScreen(program: program),
      ),
    );
  }

  void _continueProgram(UserProgram userProgram, Program program) async {
    // TODO: Navigate to workout session screen for this program
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Continuing ${program.name}...')),
    );
  }

  void _pauseProgram(UserProgram userProgram) async {
    const userId = 'demo_user'; // TODO: Get from auth
    
    try {
      final updatedUserProgram = userProgram.copyWith(
        status: 'paused',
        updatedAt: DateTime.now(),
      );
      
      final userProgramRepository = ref.read(userProgramRepositoryProvider);
      await userProgramRepository.updateUserProgram(updatedUserProgram);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Program paused')),
        );
        
        // Refresh the UI
        ref.invalidate(userProgramsProvider(userId));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pause program: $e')),
        );
      }
    }
  }

  void _resumeProgram(UserProgram userProgram) async {
    const userId = 'demo_user'; // TODO: Get from auth
    
    try {
      final updatedUserProgram = userProgram.copyWith(
        status: 'active',
        updatedAt: DateTime.now(),
      );
      
      final userProgramRepository = ref.read(userProgramRepositoryProvider);
      await userProgramRepository.updateUserProgram(updatedUserProgram);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Program resumed')),
        );
        
        // Refresh the UI
        ref.invalidate(userProgramsProvider(userId));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resume program: $e')),
        );
      }
    }
  }
}

// Program templates provider
final programTemplatesProvider = FutureProvider<List<Program>>((ref) async {
  final programRepository = ref.watch(programRepositoryProvider);
  return await programRepository.getProgramTemplates();
});