import 'package:get_it/get_it.dart';
import 'package:yd8/modules/emp_manager/data/emp_repo_impl.dart';
import 'package:yd8/modules/emp_manager/domain/add_emp_usecase.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';
import 'package:yd8/modules/emp_manager/domain/get_emps_usecase.dart';
import 'package:yd8/modules/emp_manager/domain/rem_emp_usecase.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';

final sl = GetIt.instance;

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
