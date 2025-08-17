import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/database_providers.dart';
import '../../../../domain/entities/program.dart';
import '../../../../domain/entities/user_program.dart';

// Program templates provider
final programTemplatesProvider = FutureProvider<List<Program>>((ref) async {
  final programRepository = ref.watch(programRepositoryProvider);
  return await programRepository.getProgramTemplates();
});

// User programs provider for a specific user
final userProgramsProvider = FutureProvider.family<List<UserProgram>, String>((ref, userId) async {
  final userProgramRepository = ref.watch(userProgramRepositoryProvider);
  return await userProgramRepository.getUserPrograms(userId);
});

// Active user program provider
final activeUserProgramProvider = FutureProvider.family<UserProgram?, String>((ref, userId) async {
  final userProgramRepository = ref.watch(userProgramRepositoryProvider);
  return await userProgramRepository.getActiveUserProgram(userId);
});

// Program by ID provider
final programByIdProvider = FutureProvider.family<Program?, String>((ref, programId) async {
  final programRepository = ref.watch(programRepositoryProvider);
  return await programRepository.getProgramById(programId);
});

// Start program function
Future<void> startProgram(WidgetRef ref, Program program, String userId) async {
  final userProgramRepository = ref.read(userProgramRepositoryProvider);
  
  // Create new user program instance
  final userProgram = UserProgram(
    id: 'up_${DateTime.now().millisecondsSinceEpoch}',
    userId: userId,
    programId: program.id,
    startDate: DateTime.now(),
    currentWeek: 1,
    currentDay: 1,
    status: 'active',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  
  await userProgramRepository.createUserProgram(userProgram);
  
  // Invalidate providers to refresh UI
  ref.invalidate(userProgramsProvider(userId));
  ref.invalidate(activeUserProgramProvider(userId));
}