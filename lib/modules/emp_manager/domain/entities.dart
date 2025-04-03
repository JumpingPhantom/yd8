import 'package:equatable/equatable.dart';

enum EmploymentType { fullTime, partTime }

enum EmpStatus { active, terminated, suspended, inactive }

abstract class Emp extends Equatable {
  final String? id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final List<String> phone;
  final String department;
  final String role;
  final List<String> address;
  final BigInt salary;
  final String hireDate;
  final EmploymentType type;
  final String gender;
  final EmpStatus status;
  final Map<String, dynamic> attr;

  const Emp({
    this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.department,
    required this.role,
    required this.address,
    required this.salary,
    required this.hireDate,
    required this.type,
    required this.gender,
    required this.status,
    required this.attr,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    middleName,
    lastName,
    email,
    phone,
    department,
    role,
    address,
    salary,
    hireDate,
    type,
    gender,
    status,
  ];
}

class EmpImpl extends Emp {
  const EmpImpl({
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
}
