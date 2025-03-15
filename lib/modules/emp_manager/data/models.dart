import 'package:yd8/modules/emp_manager/domain/entities.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required String id,
    required String name,
    required String attr,
  }) : super(id: id, name: name, attr: attr);

  factory EmployeeModel.fromJson(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      attr: map["attr"] ?? "",
    );
  }
}
