import 'package:equatable/equatable.dart';

abstract class Employee extends Equatable {
  final String? id;
  final String? name;
  final String? attr;

  const Employee({this.id, this.name, this.attr});

  @override
  List<Object?> get props => [id, name, attr];
}
