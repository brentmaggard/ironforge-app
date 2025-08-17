import '../../domain/entities/program.dart';
import '../../domain/repositories/program_repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/program_seeder.dart';

class ProgramRepositoryImpl implements ProgramRepository {
  final LocalDataSource _localDataSource;

  ProgramRepositoryImpl(this._localDataSource);

  @override
  Future<List<Program>> getAllPrograms() async {
    return await _localDataSource.getAllPrograms();
  }

  @override
  Future<List<Program>> getProgramTemplates() async {
    return await _localDataSource.getProgramTemplates();
  }

  @override
  Future<List<Program>> getUserPrograms(String userId) async {
    // For now, return non-template programs
    // TODO: Implement proper user program filtering
    final allPrograms = await _localDataSource.getAllPrograms();
    return allPrograms.where((p) => !p.isTemplate).toList();
  }

  @override
  Future<Program?> getProgramById(String id) async {
    return await _localDataSource.getProgramById(id);
  }

  @override
  Future<void> createProgram(Program program) async {
    await _localDataSource.createProgram(program);
  }

  @override
  Future<void> updateProgram(Program program) async {
    await _localDataSource.updateProgram(program);
  }

  @override
  Future<void> deleteProgram(String id) async {
    await _localDataSource.deleteProgram(id);
  }

  @override
  Future<void> seedProgramTemplates() async {
    // Seeding is handled by LocalDataSource initialization
    // This method can be used to manually trigger re-seeding if needed
    await ProgramSeeder.reseedProgramTemplates(_localDataSource.database);
  }

  @override
  Future<List<Program>> getProgramsByDifficulty(String difficulty) async {
    final templates = await _localDataSource.getProgramTemplates();
    return templates.where((p) => p.difficulty == difficulty).toList();
  }

  @override
  Future<List<Program>> searchPrograms(String query) async {
    final templates = await _localDataSource.getProgramTemplates();
    final queryLower = query.toLowerCase();
    return templates.where((p) => 
      p.name.toLowerCase().contains(queryLower) ||
      (p.description?.toLowerCase().contains(queryLower) ?? false) ||
      (p.author?.toLowerCase().contains(queryLower) ?? false)
    ).toList();
  }
}