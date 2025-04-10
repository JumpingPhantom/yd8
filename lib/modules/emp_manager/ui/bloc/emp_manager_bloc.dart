import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/types.dart';
import '../../domain/add_emp_usecase.dart';
import '../../domain/get_emps_usecase.dart';
import '../../domain/rem_emp_usecase.dart';
import 'emp_manager.event.dart';
import 'emp_manager_state.dart';

class EmpManagerBloc extends Bloc<EmpManagerEvent, EmpManagerState> {
  final GetEmpsUsecase _getEmployeesUsecase;
  final AddEmpUsecase _addEmpUsecase;
  final RemEmpUsecase _remEmpUsecase;

  EmpManagerBloc({
    required GetEmpsUsecase getEmployeesUsecase,
    required AddEmpUsecase addEmpUsecase,
    required RemEmpUsecase remEmpUsecase,
  }) : _getEmployeesUsecase = getEmployeesUsecase,
       _addEmpUsecase = addEmpUsecase,
       _remEmpUsecase = remEmpUsecase,
       super(EmpManagerInitial()) {
    on<GetEmps>(onFetchEmps);
    on<AddEmp>(onAddEmp);
    on<RemEmp>(onRemEmp);
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
      emit(EmpManagerError('[ERROR] : Error adding new employee'));
    }
  }

  Future<void> onRemEmp(RemEmp event, Emitter<EmpManagerState> emit) async {
    final dataState = await _remEmpUsecase(event.id);

    if (dataState is Ok) {
      await onFetchEmps(GetEmps(), emit);
    } else {
      emit(EmpManagerError('[ERROR] : Error removing employee'));
    }
  }
}
