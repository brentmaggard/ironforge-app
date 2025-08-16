import '../../domain/entities/goal.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/local_data_source.dart';

class GoalRepositoryImpl implements GoalRepository {
  final LocalDataSource _localDataSource;

  GoalRepositoryImpl(this._localDataSource);

  @override
  Future<List<Goal>> getGoalsByUserId(String userId) async {
    return await _localDataSource.getGoalsByUserId(userId);
  }

  @override
  Future<List<Goal>> getActiveGoals(String userId) async {
    return await _localDataSource.getActiveGoals(userId);
  }

  @override
  Future<List<Goal>> getCompletedGoals(String userId) async {
    return await _localDataSource.getCompletedGoals(userId);
  }

  @override
  Future<Goal?> getGoalById(String id) async {
    return await _localDataSource.getGoalById(id);
  }

  @override
  Future<void> createGoal(Goal goal) async {
    await _localDataSource.createGoal(goal);
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    await _localDataSource.updateGoal(goal);
  }

  @override
  Future<void> deleteGoal(String id) async {
    await _localDataSource.deleteGoal(id);
  }

  @override
  Future<void> updateGoalProgress(String goalId, double newProgress) async {
    await _localDataSource.updateGoalProgress(goalId, newProgress);
  }

  @override
  Future<void> completeGoal(String goalId) async {
    await _localDataSource.completeGoal(goalId);
  }
}