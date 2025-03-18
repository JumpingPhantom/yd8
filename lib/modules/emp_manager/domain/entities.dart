import 'package:equatable/equatable.dart';

abstract class Emp extends Equatable {
  final String? id;
  final String name;
  final Map<String, dynamic>? attr;

  const Emp({required this.id, required this.name, required this.attr});

  @override
  List<Object?> get props => [id, name, attr];
}

class EmpImpl extends Emp {
  const EmpImpl({super.id, required super.name, super.attr});
}
