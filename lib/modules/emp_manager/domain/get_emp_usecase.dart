import '../../../core/common/types.dart';
import 'emp_repo.dart';
import 'entities.dart';

class GetEmpUsecase extends Usecase<Result<Emp>, int> {
  final EmpRepo empRepo;

  GetEmpUsecase(this.empRepo);

  @override
  Future<Result<Emp>> call(int params) => empRepo.getEmp(params);
}
