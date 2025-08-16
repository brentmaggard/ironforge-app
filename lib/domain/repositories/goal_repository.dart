import '../entities/goal.dart';

abstract class GoalRepository {
  Future<List<Goal>> getGoalsByUserId(String userId);
  Future<List<Goal>> getActiveGoals(String userId);
  Future<List<Goal>> getCompletedGoals(String userId);
  Future<Goal?> getGoalById(String id);
  Future<void> createGoal(Goal goal);
  Future<void> updateGoal(Goal goal);
  Future<void> deleteGoal(String id);
  Future<void> updateGoalProgress(String goalId, double newProgress);
  Future<void> completeGoal(String goalId);
}