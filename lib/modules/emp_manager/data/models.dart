import 'package:yd8/modules/emp_manager/domain/entities.dart';

class EmployeeModel extends Emp {
  const EmployeeModel({
    required super.id,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.department,
    required super.role,
    required super.address,
    required super.salary,
    required super.hireDate,
    required super.type,
    required super.gender,
    required super.status,
    required super.attr,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'department': department,
      'role': role,
      'address': address,
      'salary': salary.toString(),
      'hireDate': hireDate,
      'type': type.name,
      'gender': gender,
      'status': status.name,
      'attr': attr,
    };
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String?,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: List<String>.from(json['phone'] as List),
      department: json['department'] as String,
      role: json['role'] as String,
      address: List<String>.from(json['address'] as List),
      salary: BigInt.parse(json['salary'] as String),
      hireDate: json['hireDate'] as String,
      type: EmploymentType.values.byName(json['type'] as String),
      gender: json['gender'] as String,
      status: EmpStatus.values.byName(json['status'] as String),
      attr: Map<String, dynamic>.from(json['attr'] as Map),
    );
  }
}
