import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/common/types.dart';
import '../domain/emp_repo.dart';
import '../domain/entities.dart';
import 'models.dart';

class EmpRepoImpl implements EmpRepo {
  @override
  Future<Result<List<Emp>>> getEmps() async {
    Directory dir = await getApplicationSupportDirectory();
    var file = File('${dir.path}/emps.json');

    if (!await file.exists()) {
      await file.create();
      await file.writeAsString('[]');
      return Ok(List.empty(growable: true));
    }

    List<dynamic> json = jsonDecode(await file.readAsString());

    List<EmpModel> data =
        json
            .map((item) => EmpModel.fromJson(item as Map<String, dynamic>))
            .toList();

    return Ok(data);
  }

  @override
  Future<Result<Emp>> addEmp(Emp emp) async {
    Directory dir = await getApplicationSupportDirectory();
    var file = File('${dir.path}/emps.json');

    Result<List<Emp>> emps = await getEmps();

    emps.data!.add(
      EmpModel(
        id: emp.id ?? Uuid().v4(),
        firstName: emp.firstName,
        middleName: emp.middleName ?? '',
        lastName: emp.lastName,
        email: emp.email,
        phone: emp.phone,
        department: emp.department,
        role: emp.role,
        address: emp.address,
        salary: emp.salary,
        hireDate: emp.hireDate,
        type: emp.type,
        gender: emp.gender,
        status: emp.status,
        attr: emp.attr,
      ),
    );

    await file.writeAsString(jsonEncode(emps.data));

    return Ok(emp);
  }

  @override
  Future<Result<Emp>> getEmp(int id) {
    // TODO: implement getEmp
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> remEmp(String empId) async {
    Directory dir = await getApplicationSupportDirectory();
    var file = File('${dir.path}/emps.json');

    Result<List<Emp>> emps = await getEmps();

    emps.data!.removeWhere((e) => e.id == empId);

    await file.writeAsString(jsonEncode(emps.data));

    return Ok(null);
  }
}
