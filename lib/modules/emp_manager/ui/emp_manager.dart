import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yd8/core/ui/navigation.dart';
import 'package:yd8/modules/emp_manager/di/emp_manager_di.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_appbar.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_item.dart';

class EmpManagerPage extends StatelessWidget {
  const EmpManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmpManagerBloc>(
      create: (context) => sl<EmpManagerBloc>(),
      child: AppScaffold(
        currentRoute: '/emp_manager',
        body: Builder(
          builder:
              (context) => Scaffold(
                body: ListView(children: [EmpManagerItem()]),
                appBar: EmpManagerAppBar(),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {},
                  label: Icon(Icons.person_add),
                  tooltip: "new employee",
                ),
              ),
        ),
      ),
    );
  }
}
