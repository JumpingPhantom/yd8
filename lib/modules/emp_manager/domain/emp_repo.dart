import 'package:yd8/core/data_state.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

abstract class EmpRepo {
  Future<DataState<List<Employee>>> getEmps();
}
