import 'package:yd8/core/data_state.dart';
import 'package:yd8/core/usecase.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

class GetEmpsUsecase implements Usecase<DataState<List<Employee>>, void> {
  final EmpRepo empRepo;

  const GetEmpsUsecase(this.empRepo);

  @override
  Future<DataState<List<Employee>>> call(void params) {
    throw UnimplementedError();
  }
}
