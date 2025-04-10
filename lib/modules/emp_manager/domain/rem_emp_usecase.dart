import '../../../core/common/types.dart';
import 'emp_repo.dart';

class RemEmpUsecase implements Usecase<Result<void>, String> {
  final EmpRepo empRepo;

  const RemEmpUsecase(this.empRepo);

  @override
  Future<Result<void>> call(String params) => empRepo.remEmp(params);
}
