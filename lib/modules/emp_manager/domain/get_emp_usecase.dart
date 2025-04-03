import 'package:yd8/core/util/data_state.dart';
import 'package:yd8/core/util/usecase.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

class GetEmpUsecase extends Usecase<Result<Emp>, int> {
  final EmpRepo empRepo;

  GetEmpUsecase(this.empRepo);

  @override
  Future<Result<Emp>> call(int params) => empRepo.getEmp(params);
}
