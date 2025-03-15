import 'package:yd8/core/data_state.dart';
import 'package:yd8/core/usecase.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

class GetEmpUsecase extends Usecase<DataState<Employee>, Employee> {
  @override
  Future<DataState<Employee>> call(Employee params) {
    throw UnimplementedError();
  }
}
