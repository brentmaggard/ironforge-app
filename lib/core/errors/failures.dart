import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure({required this.message, this.code});
  
  final String message;
  final String? code;
  
  @override
  List<Object?> get props => [message, code];
}

/// Database related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.code});
}

/// Network related failures (for future Supabase integration)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

/// Cache related failures
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// General failures
class GeneralFailure extends Failure {
  const GeneralFailure({required super.message, super.code});
}