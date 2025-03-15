import 'package:get_it/get_it.dart';
import 'package:yd8/modules/emp_manager/data/emp_repo_impl.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';
import 'package:yd8/modules/emp_manager/domain/get_emps_usecase.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';

final sl = GetIt.instance;

void initEmpManagerDependencies() {
  sl.registerLazySingleton<EmpRepo>(() => EmpRepoImpl());
  sl.registerLazySingleton(() => GetEmpsUsecase(sl()));
  sl.registerFactory<EmpManagerBloc>(
    () => EmpManagerBloc(getEmployeesUsecase: sl()),
  );
}
