import 'package:equatable/equatable.dart';
import '../../domain/entities.dart';

abstract class EmpManagerEvent extends Equatable {
  const EmpManagerEvent();

  @override
  List<Object?> get props => [];
}

class GetEmps extends EmpManagerEvent {}

class AddEmp extends EmpManagerEvent {
  final Emp emp;

  const AddEmp({required this.emp});
}

class RemEmp extends EmpManagerEvent {
  final String id;

  const RemEmp({required this.id});
}

class EditEmp extends EmpManagerEvent {}
