import '../../../core/common/types.dart';
import 'emp_repo.dart';
import 'entities.dart';

class GetEmpsUsecase implements Usecase<Result<List<Emp>>, void> {
  final EmpRepo empRepo;

  GetEmpsUsecase(this.empRepo);

  @override
  Future<Result<List<Emp>>> call(void params) => empRepo.getEmps();
}
