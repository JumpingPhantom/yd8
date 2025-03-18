import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yd8/core/data_state.dart';
import 'package:yd8/modules/emp_manager/domain/add_emp_usecase.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';
import 'package:yd8/modules/emp_manager/domain/get_emps_usecase.dart';

// events
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

class RemoveEmp extends EmpManagerEvent {}

class EditEmp extends EmpManagerEvent {}

// states
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

class EmpManagerBloc extends Bloc<EmpManagerEvent, EmpManagerState> {
  final GetEmpsUsecase _getEmployeesUsecase;
  final AddEmpUsecase _addEmpUsecase;

  EmpManagerBloc({
    required GetEmpsUsecase getEmployeesUsecase,
    required AddEmpUsecase addEmpUsecase,
  }) : _getEmployeesUsecase = getEmployeesUsecase,
       _addEmpUsecase = addEmpUsecase,
       super(EmpManagerInitial()) {
    on<GetEmps>(onFetchEmps);
    on<AddEmp>(onAddEmp);
  }

  Future<void> onFetchEmps(GetEmps event, Emitter<EmpManagerState> emit) async {
    emit(EmpManagerLoading());

    final dataState = await _getEmployeesUsecase(null);

    if (dataState is Ok) {
      emit(EmpManagerLoaded(dataState.data!));
    } else {
      emit(EmpManagerError("[ERROR] : Couldn't fetch employees"));
      throw dataState;
    }
  }

  Future<void> onAddEmp(AddEmp event, Emitter<EmpManagerState> emit) async {
    final dataState = await _addEmpUsecase(event.emp);

    if (dataState is Ok) {
      await onFetchEmps(GetEmps(), emit);
    } else {
      emit(EmpManagerError("[ERROR] : Error adding new employee"));
    }
  }
}
