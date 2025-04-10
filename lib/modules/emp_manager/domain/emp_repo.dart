import '../../../core/common/types.dart';
import 'entities.dart';

abstract class EmpRepo {
  Future<Result<List<Emp>>> getEmps();
  Future<Result<Emp>> getEmp(int id);
  Future<Result<void>> remEmp(String emp);
  Future<Result<Emp>> addEmp(Emp emp);
}
