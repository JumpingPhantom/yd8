import 'package:yd8/core/util/data_state.dart';
import 'package:yd8/core/util/usecase.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

class GetEmpsUsecase implements Usecase<Result<List<Emp>>, void> {
  final EmpRepo empRepo;

  GetEmpsUsecase(this.empRepo);

  @override
  Future<Result<List<Emp>>> call(void params) => empRepo.getEmps();
}
