import 'package:yd8/core/data_state.dart';
import 'package:yd8/modules/emp_manager/data/models.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';

final testData = EmployeeModel(id: "324987", name: "John Doe", attr: "test");

class EmpRepoImpl implements EmpRepo {
  @override
  Future<DataState<List<EmployeeModel>>> getEmps() async {
    return DataSuccess([testData, testData, testData, testData]);
  }
}
