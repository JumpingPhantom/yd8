import '../../../core/common/types.dart';
import 'emp_repo.dart';
import 'entities.dart';

class AddEmpUsecase extends Usecase<Result<void>, Emp> {
  final EmpRepo empRepo;

  AddEmpUsecase(this.empRepo);

  @override
  Future<Result<void>> call(Emp params) => empRepo.addEmp(params);
}
