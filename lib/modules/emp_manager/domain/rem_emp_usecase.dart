import 'package:yd8/core/util/data_state.dart';
import 'package:yd8/core/util/usecase.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';

class RemEmpUsecase implements Usecase<Result<void>, String> {
  final EmpRepo empRepo;

  const RemEmpUsecase(this.empRepo);

  @override
  Future<Result<void>> call(String params) => empRepo.remEmp(params);
}
