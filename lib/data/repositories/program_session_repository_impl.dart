import '../../domain/entities/program_session.dart';
import '../../domain/repositories/program_session_repository.dart';
import '../datasources/local_data_source.dart';

class ProgramSessionRepositoryImpl implements ProgramSessionRepository {
  final LocalDataSource _localDataSource;

  ProgramSessionRepositoryImpl(this._localDataSource);

  @override
  Future<List<ProgramSession>> getSessionsByUserProgram(String userProgramId) async {
    return await _localDataSource.getSessionsByUserProgram(userProgramId);
  }

  @override
  Future<ProgramSession?> getSessionById(String id) async {
    return await _localDataSource.getSessionById(id);
  }

  @override
  Future<ProgramSession?> getSessionByWeekDay(String userProgramId, int weekNumber, int dayNumber) async {
    return await _localDataSource.getSessionByWeekDay(userProgramId, weekNumber, dayNumber);
  }

  @override
  Future<void> createSession(ProgramSession session) async {
    await _localDataSource.createProgramSession(session);
  }

  @override
  Future<void> updateSession(ProgramSession session) async {
    await _localDataSource.updateProgramSession(session);
  }

  @override
  Future<void> deleteSession(String id) async {
    await _localDataSource.deleteProgramSession(id);
  }

  @override
  Future<void> scheduleSession(String userProgramId, int weekNumber, int dayNumber, DateTime scheduledDate) async {
    final existingSession = await _localDataSource.getSessionByWeekDay(userProgramId, weekNumber, dayNumber);
    
    if (existingSession != null) {
      // Update existing session
      final updatedSession = existingSession.copyWith(
        scheduledDate: scheduledDate,
        status: 'scheduled',
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateProgramSession(updatedSession);
    } else {
      // Create new session
      final newSession = ProgramSession(
        id: 'ps_${DateTime.now().millisecondsSinceEpoch}',
        userProgramId: userProgramId,
        weekNumber: weekNumber,
        dayNumber: dayNumber,
        scheduledDate: scheduledDate,
        status: 'scheduled',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _localDataSource.createProgramSession(newSession);
    }
  }

  @override
  Future<void> completeSession(String sessionId, String workoutId) async {
    final session = await _localDataSource.getSessionById(sessionId);
    if (session != null) {
      final updatedSession = session.copyWith(
        workoutId: workoutId,
        completedAt: DateTime.now(),
        status: 'completed',
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateProgramSession(updatedSession);
    }
  }

  @override
  Future<void> skipSession(String sessionId, String reason) async {
    final session = await _localDataSource.getSessionById(sessionId);
    if (session != null) {
      final updatedSession = session.copyWith(
        status: 'skipped',
        notes: reason,
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateProgramSession(updatedSession);
    }
  }

  @override
  Future<List<ProgramSession>> getUpcomingSessions(String userProgramId, {int limit = 7}) async {
    return await _localDataSource.getUpcomingSessions(userProgramId, limit: limit);
  }

  @override
  Future<List<ProgramSession>> getCompletedSessions(String userProgramId) async {
    return await _localDataSource.getCompletedSessions(userProgramId);
  }

  @override
  Future<ProgramSession?> getNextSession(String userProgramId) async {
    final upcomingSessions = await _localDataSource.getUpcomingSessions(userProgramId, limit: 1);
    return upcomingSessions.isNotEmpty ? upcomingSessions.first : null;
  }
}