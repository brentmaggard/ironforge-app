import '../entities/user_program.dart';

abstract class UserProgramRepository {
  Future<List<UserProgram>> getUserPrograms(String userId);
  Future<UserProgram?> getActiveUserProgram(String userId);
  Future<UserProgram?> getUserProgramById(String id);
  Future<void> createUserProgram(UserProgram userProgram);
  Future<void> updateUserProgram(UserProgram userProgram);
  Future<void> deleteUserProgram(String id);
  
  // Program progression operations
  Future<void> advanceUserProgram(String userProgramId, int weekNumber, int dayNumber);
  Future<void> pauseUserProgram(String userProgramId);
  Future<void> resumeUserProgram(String userProgramId);
  Future<void> completeUserProgram(String userProgramId);
}