import 'package:yd8/core/data_state.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

abstract class EmpRepo {
  Future<Result<List<Emp>>> getEmps();
  Future<Result<Emp>> getEmp(int id);
  Future<Result<void>> remEmp(Emp emp);
  Future<Result<Emp>> addEmp(Emp emp);
}
