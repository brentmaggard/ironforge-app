import '../entities/program_session.dart';

abstract class ProgramSessionRepository {
  Future<List<ProgramSession>> getSessionsByUserProgram(String userProgramId);
  Future<ProgramSession?> getSessionById(String id);
  Future<ProgramSession?> getSessionByWeekDay(String userProgramId, int weekNumber, int dayNumber);
  Future<void> createSession(ProgramSession session);
  Future<void> updateSession(ProgramSession session);
  Future<void> deleteSession(String id);
  
  // Session scheduling and completion
  Future<void> scheduleSession(String userProgramId, int weekNumber, int dayNumber, DateTime scheduledDate);
  Future<void> completeSession(String sessionId, String workoutId);
  Future<void> skipSession(String sessionId, String reason);
  
  // Session queries
  Future<List<ProgramSession>> getUpcomingSessions(String userProgramId, {int limit = 7});
  Future<List<ProgramSession>> getCompletedSessions(String userProgramId);
  Future<ProgramSession?> getNextSession(String userProgramId);
}