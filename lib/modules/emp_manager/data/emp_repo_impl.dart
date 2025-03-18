import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:yd8/core/data_state.dart';
import 'package:yd8/modules/emp_manager/data/models.dart';
import 'package:yd8/modules/emp_manager/domain/emp_repo.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

class EmpRepoImpl implements EmpRepo {
  @override
  Future<Result<List<EmployeeModel>>> getEmps() async {
    Directory dir = await getApplicationSupportDirectory();
    var file = File('${dir.path}/emps.json');

    if (!await file.exists()) {
      await file.create();
      await file.writeAsString('[]');
      return Ok(List.empty(growable: true));
    }

    List<dynamic> json = jsonDecode(await file.readAsString());

    List<EmployeeModel> data =
        json
            .map((item) => EmployeeModel.fromJson(item as Map<String, dynamic>))
            .toList();

    return Ok(data);
  }

  @override
  Future<Result<Emp>> addEmp(Emp emp) async {
    Directory dir = await getApplicationSupportDirectory();
    var file = File('${dir.path}/emps.json');

    Result<List<Emp>> emps = await getEmps();

    emps.data!.add(EmployeeModel.create(emp.name, emp.attr));

    await file.writeAsString(jsonEncode(emps.data));

    return Ok(emp);
  }

  @override
  Future<Result<Emp>> getEmp(int id) {
    // TODO: implement getEmp
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> remEmp(Emp emp) {
    // TODO: implement remEmp
    throw UnimplementedError();
  }
}
