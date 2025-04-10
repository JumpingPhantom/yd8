// states
import 'package:equatable/equatable.dart';

import '../../domain/entities.dart';

abstract class EmpManagerState extends Equatable {
  const EmpManagerState();

  @override
  List<Object> get props => [];
}

class EmpManagerInitial extends EmpManagerState {}

class EmpManagerLoading extends EmpManagerState {}

class EmpManagerLoaded extends EmpManagerState {
  final List<Emp> emps;

  const EmpManagerLoaded(this.emps);

  @override
  List<Object> get props => [emps];
}

class EmpManagerError extends EmpManagerState {
  final String message;

  const EmpManagerError(this.message);

  @override
  List<Object> get props => [message];
}
