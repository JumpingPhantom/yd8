import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_emp_details.dart';

class EmpManagerList extends StatefulWidget {
  final List<Emp> children;

  const EmpManagerList({super.key, required this.children});

  @override
  State<EmpManagerList> createState() => _EmpManagerListState();
}

class _EmpManagerListState extends State<EmpManagerList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.children.map((emp) => _EmpManagerListItem(emp)).toList(),
    );
  }
}

class _EmpManagerListItem extends StatelessWidget {
  final Emp emp;

  const _EmpManagerListItem(this.emp);

  @override
  Widget build(BuildContext context) {
    final empBloc = context.read<EmpManagerBloc>();

    return ListTile(
      leading: const FlutterLogo(size: 48.0),
      title: Text(emp.firstName),
      subtitle: Text(emp.id.toString()),
      onTap: () {
        showDialog(
          context: context,
          builder:
              (_) => EmpManagerEmpDetails(
                emp,
                onEditEmp: (_) {},
                onDeleteEmp: (_) {
                  empBloc.add(RemEmp(id: emp.id!));
                  Navigator.of(context).pop();
                },
              ),
        );
      },
    );
  }
}
