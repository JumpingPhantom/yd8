import 'package:yd8/core/data_state.dart';
import 'package:yd8/core/usecase.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

class AddEmpUsecase extends Usecase<Result<void>, Emp> {
  final EmpRepo empRepo;

  AddEmpUsecase(this.empRepo);

  @override
  Future<Result<void>> call(Emp params) => empRepo.addEmp(params);
}
