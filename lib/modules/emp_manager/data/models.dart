import 'package:uuid/uuid.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

class EmployeeModel extends Emp {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.attr,
  });

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "attr": attr};
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> map) {
    return EmployeeModel(id: map["id"], name: map["name"], attr: map["attr"]);
  }

  factory EmployeeModel.create(String name, Map<String, dynamic>? attr) {
    return EmployeeModel(
      id: Uuid().v4(),
      name: name,
      attr: attr ?? Map.identity(),
    );
  }
}
