import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yd8/core/data_state.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';
import 'package:yd8/modules/emp_manager/domain/get_emps_usecase.dart';

abstract class EmpManagerEvent extends Equatable {
  const EmpManagerEvent();

  @override
  List<Object?> get props => [];
}

class GetEmps extends EmpManagerEvent {}

abstract class EmpManagerState extends Equatable {
  const EmpManagerState();

  @override
  List<Object> get props => [];
}

class EmpManagerInitial extends EmpManagerState {}

class EmpManagerLoading extends EmpManagerState {}

class EmpManagerLoaded extends EmpManagerState {
  final List<Employee> employees;

  const EmpManagerLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

class EmpManagerError extends EmpManagerState {
  final String message;

  const EmpManagerError(this.message);

  @override
  List<Object> get props => [message];
}

class EmpManagerBloc extends Bloc<EmpManagerEvent, EmpManagerState> {
  final GetEmpsUsecase _getEmployeesUsecase;

  EmpManagerBloc({required GetEmpsUsecase getEmployeesUsecase})
    : _getEmployeesUsecase = getEmployeesUsecase,
      super(EmpManagerInitial()) {
    on<GetEmps>(onFetchEmployees);
  }

  Future<void> onFetchEmployees(
    GetEmps event,
    Emitter<EmpManagerState> emit,
  ) async {
    emit(EmpManagerLoading());

    final dataState = await _getEmployeesUsecase(null);

    if (dataState is DataSuccess) {
      emit(EmpManagerLoaded(dataState.data!));
    } else {
      emit(EmpManagerError("[ERROR] : Couldn't fetch employees"));
      throw dataState;
    }
  }
}
