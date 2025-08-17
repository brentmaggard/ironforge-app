import 'package:flutter/material.dart';
import '../../../../domain/entities/program.dart';

class ProgramScheduleEditor extends StatefulWidget {
  final Program program;
  final ValueChanged<Program> onProgramChanged;

  const ProgramScheduleEditor({
    super.key,
    required this.program,
    required this.onProgramChanged,
  });

  @override
  State<ProgramScheduleEditor> createState() => _ProgramScheduleEditorState();
}

class _ProgramScheduleEditorState extends State<ProgramScheduleEditor> {
  late List<String> _schedule;
  late Map<String, ProgramWorkout> _workouts;

  @override
  void initState() {
    super.initState();
    _schedule = List.from(widget.program.schedule);
    _workouts = Map.from(widget.program.workouts);
    
    // Ensure schedule has at least 7 days
    while (_schedule.length < 7) {
      _schedule.add('rest');
    }
  }

  void _updateProgram() {
    final updatedConfig = Map<String, dynamic>.from(widget.program.config);
    updatedConfig['schedule'] = _schedule;
    
    final updatedProgram = widget.program.copyWith(
      config: updatedConfig,
      updatedAt: DateTime.now(),
    );
    
    widget.onProgramChanged(updatedProgram);
  }

  void _updateScheduleItem(int index, String value) {
    setState(() {
      // Ensure schedule is long enough to accommodate the index
      while (_schedule.length <= index) {
        _schedule.add('rest');
      }
      _schedule[index] = value;
    });
    _updateProgram();
  }

  void _addWeek() {
    setState(() {
      // Add 7 more days (repeat current pattern or add rest days)
      for (int i = 0; i < 7; i++) {
        _schedule.add('rest');
      }
    });
    _updateProgram();
  }

  void _removeWeek() {
    if (_schedule.length > 7) {
      setState(() {
        // Remove last 7 days
        for (int i = 0; i < 7 && _schedule.length > 7; i++) {
          _schedule.removeLast();
        }
      });
      _updateProgram();
    }
  }

  void _duplicateWeek(int weekIndex) {
    final weekStart = weekIndex * 7;
    final weekEnd = weekStart + 7;
    
    if (weekEnd <= _schedule.length) {
      final weekToClone = _schedule.sublist(weekStart, weekEnd);
      setState(() {
        _schedule.addAll(weekToClone);
      });
      _updateProgram();
    }
  }

  List<String> get _availableWorkouts {
    return ['rest', ..._workouts.keys];
  }

  List<List<String>> get _weeklySchedule {
    final weeks = <List<String>>[];
    for (int i = 0; i < _schedule.length; i += 7) {
      final weekEnd = (i + 7 < _schedule.length) ? i + 7 : _schedule.length;
      final week = _schedule.sublist(i, weekEnd);
      
      // Ensure each week has exactly 7 days, padding with 'rest' if necessary
      while (week.length < 7) {
        week.add('rest');
      }
      
      weeks.add(week);
    }
    return weeks;
  }

  @override
  Widget build(BuildContext context) {
    final weeks = _weeklySchedule;
    
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text(
                'Program Schedule',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '${weeks.length} week${weeks.length != 1 ? 's' : ''}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        // Schedule management buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: _addWeek,
                icon: const Icon(Icons.add),
                label: const Text('Add Week'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: weeks.length > 1 ? _removeWeek : null,
                icon: const Icon(Icons.remove),
                label: const Text('Remove Week'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),

        // Schedule grid and summary in scrollable area
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Week cards
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, weekIndex) {
                    final week = weeks[weekIndex];
                    return WeekCard(
                      weekNumber: weekIndex + 1,
                      week: week,
                      availableWorkouts: _availableWorkouts,
                      onDayChanged: (dayIndex, value) {
                        final scheduleIndex = weekIndex * 7 + dayIndex;
                        _updateScheduleItem(scheduleIndex, value);
                      },
                      onDuplicateWeek: () => _duplicateWeek(weekIndex),
                    );
                  },
                  childCount: weeks.length,
                ),
              ),
              
              // Schedule summary as a sliver
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Schedule Summary',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildScheduleSummary(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleSummary() {
    final workoutCounts = <String, int>{};
    int restDays = 0;
    
    for (final day in _schedule) {
      if (day == 'rest') {
        restDays++;
      } else {
        workoutCounts[day] = (workoutCounts[day] ?? 0) + 1;
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total days: ${_schedule.length}'),
        Text('Rest days: $restDays'),
        ...workoutCounts.entries.map(
          (entry) => Text('${entry.key}: ${entry.value} days'),
        ),
      ],
    );
  }
}

class WeekCard extends StatelessWidget {
  final int weekNumber;
  final List<String> week;
  final List<String> availableWorkouts;
  final void Function(int dayIndex, String value) onDayChanged;
  final VoidCallback onDuplicateWeek;

  const WeekCard({
    super.key,
    required this.weekNumber,
    required this.week,
    required this.availableWorkouts,
    required this.onDayChanged,
    required this.onDuplicateWeek,
  });

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week header
            Row(
              children: [
                Text(
                  'Week $weekNumber',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onDuplicateWeek,
                  icon: const Icon(Icons.copy),
                  tooltip: 'Duplicate this week',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Days grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.9, // Slightly taller to accommodate content
              ),
              itemCount: 7, // Always 7 days in a week
              itemBuilder: (context, dayIndex) {
                final day = daysOfWeek[dayIndex]; // Safe since we know dayIndex < 7
                final workout = week[dayIndex]; // Safe since week is guaranteed to have 7 elements
                
                return DaySelector(
                  day: day,
                  selectedWorkout: workout,
                  availableWorkouts: availableWorkouts,
                  onChanged: (value) => onDayChanged(dayIndex, value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DaySelector extends StatelessWidget {
  final String day;
  final String selectedWorkout;
  final List<String> availableWorkouts;
  final ValueChanged<String> onChanged;

  const DaySelector({
    super.key,
    required this.day,
    required this.selectedWorkout,
    required this.availableWorkouts,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 60, // Ensure minimum height
              maxHeight: 80, // Prevent overflow
            ),
            decoration: BoxDecoration(
              color: selectedWorkout == 'rest' ? Colors.grey[100] : Colors.blue[50],
              border: Border.all(
                color: selectedWorkout == 'rest' ? Colors.grey[300]! : Colors.blue[300]!,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                _showWorkoutSelector(context);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selectedWorkout == 'rest' ? Icons.hotel : Icons.fitness_center,
                      size: 16,
                      color: selectedWorkout == 'rest' ? Colors.grey[600] : Colors.blue[600],
                    ),
                    const SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        selectedWorkout == 'rest' ? 'Rest' : selectedWorkout,
                        style: TextStyle(
                          fontSize: 10,
                          color: selectedWorkout == 'rest' ? Colors.grey[700] : Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showWorkoutSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select workout for $day',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...availableWorkouts.map((workout) => ListTile(
              leading: Icon(
                workout == 'rest' ? Icons.hotel : Icons.fitness_center,
              ),
              title: Text(workout == 'rest' ? 'Rest Day' : workout),
              selected: workout == selectedWorkout,
              onTap: () {
                onChanged(workout);
                Navigator.of(context).pop();
              },
            )),
          ],
        ),
      ),
    );
  }
}