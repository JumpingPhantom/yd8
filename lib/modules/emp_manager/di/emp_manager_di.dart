import '../../../core/common/util.dart';
import '../data/emp_repo_impl.dart';
import '../domain/add_emp_usecase.dart';
import '../domain/emp_repo.dart';
import '../domain/get_emps_usecase.dart';
import '../domain/rem_emp_usecase.dart';
import '../ui/bloc/emp_manager_bloc.dart';

void initEmpManagerDependencies() {
  // repos
  sl.registerLazySingleton<EmpRepo>(() => EmpRepoImpl());

  // usecases
  sl.registerLazySingleton(() => GetEmpsUsecase(sl()));
  sl.registerLazySingleton(() => AddEmpUsecase(sl()));
  sl.registerLazySingleton(() => RemEmpUsecase(sl()));

  // blocs
  sl.registerFactory<EmpManagerBloc>(
    () => EmpManagerBloc(
      getEmployeesUsecase: sl(),
      addEmpUsecase: sl(),
      remEmpUsecase: sl(),
    ),
  );
}
