import '../entities/program.dart';

abstract class ProgramRepository {
  Future<List<Program>> getAllPrograms();
  Future<List<Program>> getProgramTemplates();
  Future<List<Program>> getUserPrograms(String userId);
  Future<Program?> getProgramById(String id);
  Future<void> createProgram(Program program);
  Future<void> updateProgram(Program program);
  Future<void> deleteProgram(String id);
  
  // Program template operations
  Future<void> seedProgramTemplates();
  Future<List<Program>> getProgramsByDifficulty(String difficulty);
  Future<List<Program>> searchPrograms(String query);
}