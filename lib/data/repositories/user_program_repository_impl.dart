import '../../domain/entities/user_program.dart';
import '../../domain/repositories/user_program_repository.dart';
import '../datasources/local_data_source.dart';

class UserProgramRepositoryImpl implements UserProgramRepository {
  final LocalDataSource _localDataSource;

  UserProgramRepositoryImpl(this._localDataSource);

  @override
  Future<List<UserProgram>> getUserPrograms(String userId) async {
    return await _localDataSource.getUserPrograms(userId);
  }

  @override
  Future<UserProgram?> getActiveUserProgram(String userId) async {
    return await _localDataSource.getActiveUserProgram(userId);
  }

  @override
  Future<UserProgram?> getUserProgramById(String id) async {
    return await _localDataSource.getUserProgramById(id);
  }

  @override
  Future<void> createUserProgram(UserProgram userProgram) async {
    await _localDataSource.createUserProgram(userProgram);
  }

  @override
  Future<void> updateUserProgram(UserProgram userProgram) async {
    await _localDataSource.updateUserProgram(userProgram);
  }

  @override
  Future<void> deleteUserProgram(String id) async {
    await _localDataSource.deleteUserProgram(id);
  }

  @override
  Future<void> advanceUserProgram(String userProgramId, int weekNumber, int dayNumber) async {
    final userProgram = await _localDataSource.getUserProgramById(userProgramId);
    if (userProgram != null) {
      final updatedProgram = userProgram.copyWith(
        currentWeek: weekNumber,
        currentDay: dayNumber,
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateUserProgram(updatedProgram);
    }
  }

  @override
  Future<void> pauseUserProgram(String userProgramId) async {
    final userProgram = await _localDataSource.getUserProgramById(userProgramId);
    if (userProgram != null) {
      final updatedProgram = userProgram.copyWith(
        status: 'paused',
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateUserProgram(updatedProgram);
    }
  }

  @override
  Future<void> resumeUserProgram(String userProgramId) async {
    final userProgram = await _localDataSource.getUserProgramById(userProgramId);
    if (userProgram != null) {
      final updatedProgram = userProgram.copyWith(
        status: 'active',
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateUserProgram(updatedProgram);
    }
  }

  @override
  Future<void> completeUserProgram(String userProgramId) async {
    final userProgram = await _localDataSource.getUserProgramById(userProgramId);
    if (userProgram != null) {
      final updatedProgram = userProgram.copyWith(
        status: 'completed',
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateUserProgram(updatedProgram);
    }
  }
}