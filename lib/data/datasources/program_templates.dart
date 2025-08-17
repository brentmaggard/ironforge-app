import '../../domain/entities/program.dart';

class ProgramTemplates {
  static List<Program> get allTemplates => [
    basicBeginnerProgram,
    strongLifts5x5Program,
    startingStrengthProgram,
    fiveThreeOneBeginnerProgram,
  ];

  /// Basic Beginner Routine - 3-month linear progression program for complete beginners
  /// Based on /r/fitness recommended routine
  static Program get basicBeginnerProgram => Program(
    id: 'basic_beginner_routine',
    name: 'Basic Beginner Routine',
    description: 'A 3-month linear progression program designed for complete beginners to weight lifting. Focuses on the fundamental compound movements with simple progression.',
    author: '/r/fitness',
    difficulty: 'beginner',
    frequency: 3, // 3 days per week
    durationWeeks: 12,
    tags: ['strength', 'beginner', 'full-body', 'linear-progression'],
    config: {
      'workouts': {
        'A': {
          'name': 'Workout A',
          'exercises': [
            {
              'exerciseId': 'bent_over_row', // From existing exercise database
              'sets': [
                {'reps': 5, 'weight': 95.0, 'type': 'normal'},
                {'reps': 5, 'weight': 95.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 95.0, 'type': 'amrap'},
              ],
              'restTime': 180, // 3 minutes
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'bench_press',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 45.0, 'type': 'amrap'},
              ],
              'restTime': 180,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'squat',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 45.0, 'type': 'amrap'},
              ],
              'restTime': 180,
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
          ],
        },
        'B': {
          'name': 'Workout B',
          'exercises': [
            {
              'exerciseId': 'chin_up',
              'sets': [
                {'reps': 5, 'weight': 0.0, 'type': 'normal'},
                {'reps': 5, 'weight': 0.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 0.0, 'type': 'amrap'},
              ],
              'restTime': 180,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'overhead_press',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 45.0, 'type': 'amrap'},
              ],
              'restTime': 180,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'deadlift',
              'sets': [
                {'reps': 5, 'weight': 95.0, 'type': 'normal'},
                {'reps': 5, 'weight': 95.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 95.0, 'type': 'amrap'},
              ],
              'restTime': 180,
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
          ],
        },
      },
      'schedule': ['A', 'B', 'A', 'rest', 'B', 'A', 'B'], // Weekly pattern
      'progressionRules': {
        'failureThreshold': 3, // Deload after 3 consecutive failures
        'deloadPercentage': 10, // Reduce weight by 10%
        'successCriteria': 'complete_all_sets',
      },
    },
    isTemplate: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  /// StrongLifts 5x5 - Classic 5x5 linear progression program
  static Program get strongLifts5x5Program => Program(
    id: 'stronglifts_5x5',
    name: 'StrongLifts 5x5',
    description: 'Simple but effective muscle and strength building workout based on 5 sets of 5 reps at roughly 85% 1RM.',
    author: 'Mehdi Hadim',
    difficulty: 'beginner',
    frequency: 3,
    durationWeeks: 12,
    tags: ['strength', 'beginner', 'powerlifting', 'linear-progression'],
    config: {
      'workouts': {
        'A': {
          'name': 'Workout A',
          'exercises': [
            {
              'exerciseId': 'squat',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300, // 5 minutes
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'bench_press',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'bent_over_row',
              'sets': [
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
          ],
        },
        'B': {
          'name': 'Workout B',
          'exercises': [
            {
              'exerciseId': 'squat',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'overhead_press',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'deadlift',
              'sets': [
                {'reps': 5, 'weight': 95.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
          ],
        },
      },
      'schedule': ['A', 'B', 'A', 'rest', 'B', 'A', 'B'],
      'progressionRules': {
        'failureThreshold': 3,
        'deloadPercentage': 10,
        'successCriteria': 'complete_all_sets',
      },
    },
    isTemplate: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  /// Starting Strength - Mark Rippetoe's classic beginner program
  static Program get startingStrengthProgram => Program(
    id: 'starting_strength',
    name: 'Starting Strength',
    description: 'Mark Rippetoe\'s basic barbell training program focusing on the fundamental lifts with linear progression.',
    author: 'Mark Rippetoe',
    difficulty: 'beginner',
    frequency: 3,
    durationWeeks: 12,
    tags: ['strength', 'beginner', 'powerlifting', 'barbell'],
    config: {
      'workouts': {
        'A': {
          'name': 'Workout A',
          'exercises': [
            {
              'exerciseId': 'squat',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'overhead_press',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'deadlift',
              'sets': [
                {'reps': 5, 'weight': 95.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
          ],
        },
        'B': {
          'name': 'Workout B',
          'exercises': [
            {
              'exerciseId': 'squat',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'bench_press',
              'sets': [
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
                {'reps': 5, 'weight': 45.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
            {
              'exerciseId': 'bent_over_row',
              'sets': [
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'linear',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'session',
              },
            },
          ],
        },
      },
      'schedule': ['A', 'B', 'A', 'rest', 'B', 'A', 'B'],
      'progressionRules': {
        'failureThreshold': 3,
        'deloadPercentage': 10,
        'successCriteria': 'complete_all_sets',
      },
    },
    isTemplate: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  /// 5/3/1 for Beginners - Jim Wendler's percentage-based program for beginners
  static Program get fiveThreeOneBeginnerProgram => Program(
    id: 'five_three_one_beginner',
    name: '5/3/1 for Beginners',
    description: 'Jim Wendler\'s 5/3/1 methodology adapted for beginners with percentage-based progression.',
    author: 'Jim Wendler',
    difficulty: 'intermediate',
    frequency: 3,
    durationWeeks: 16,
    tags: ['strength', 'intermediate', 'percentage-based', 'powerlifting'],
    config: {
      'workouts': {
        'A': {
          'name': 'Squat/Bench Day',
          'exercises': [
            {
              'exerciseId': 'squat',
              'sets': [
                {'reps': 5, 'weight': 65.0, 'type': 'normal'}, // 65% of TM
                {'reps': 5, 'weight': 75.0, 'type': 'normal'}, // 75% of TM
                {'reps': '5+', 'weight': 85.0, 'type': 'amrap'}, // 85% of TM
              ],
              'restTime': 300,
              'progression': {
                'type': 'percentage',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'monthly',
              },
            },
            {
              'exerciseId': 'bench_press',
              'sets': [
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 75.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 85.0, 'type': 'amrap'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'percentage',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'monthly',
              },
            },
          ],
        },
        'B': {
          'name': 'Deadlift/Press Day',
          'exercises': [
            {
              'exerciseId': 'deadlift',
              'sets': [
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 75.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 85.0, 'type': 'amrap'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'percentage',
                'increment': 5.0,
                'unit': 'lbs',
                'frequency': 'monthly',
              },
            },
            {
              'exerciseId': 'overhead_press',
              'sets': [
                {'reps': 5, 'weight': 65.0, 'type': 'normal'},
                {'reps': 5, 'weight': 75.0, 'type': 'normal'},
                {'reps': '5+', 'weight': 85.0, 'type': 'amrap'},
              ],
              'restTime': 300,
              'progression': {
                'type': 'percentage',
                'increment': 2.5,
                'unit': 'lbs',
                'frequency': 'monthly',
              },
            },
          ],
        },
      },
      'schedule': ['A', 'B', 'A', 'rest', 'B', 'A', 'B'],
      'progressionRules': {
        'failureThreshold': 2,
        'deloadPercentage': 10,
        'successCriteria': 'amrap_progression',
      },
    },
    isTemplate: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}