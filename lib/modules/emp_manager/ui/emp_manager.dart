import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yd8/modules/emp_manager/di/emp_manager_di.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_appbar.dart';

import '../../../core/navigation/nav.dart';

class EmpManagerPage extends StatelessWidget {
  const EmpManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmpManagerBloc>(
      create: (context) => sl<EmpManagerBloc>(),
      child: AppScaffold(
        title: "Employee Manager",
        currentRoute: '/emp_manager',
        body: Builder(
          builder: (context) {
            final empBloc = context.watch<EmpManagerBloc>();

            return Scaffold(
              body: Builder(
                builder: (context) {
                  if (empBloc.state is EmpManagerInitial) {
                    empBloc.add(GetEmps());
                  } else if (empBloc.state is EmpManagerLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (empBloc.state is EmpManagerLoaded) {
                    List<Emp> emps = (empBloc.state as EmpManagerLoaded).emps;

                    if (emps.isEmpty) return Text("Such Empty, much wow!");

                    return ListView(
                      children:
                          emps
                              .map(
                                (emp) => ListTile(
                                  leading: FlutterLogo(),
                                  title: Text(emp.name),
                                  subtitle: Text(emp.id!.toString()),
                                ),
                              )
                              .toList(),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
              appBar: EmpManagerAppBar(),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  context.read<EmpManagerBloc>().add(
                    AddEmp(emp: EmpImpl(name: "Yoann Garel")),
                  );
                },
                label: Icon(Icons.person_add),
                tooltip: "new employee",
              ),
            );
          },
        ),
      ),
    );
  }
}
