import 'package:flutter/material.dart';
import '../../domain/entities.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/emp_tile.dart';

class EmpManagerList extends StatefulWidget {
  final List<Emp> emps;

  const EmpManagerList({super.key, required this.emps});

  @override
  State<EmpManagerList> createState() => _EmpManagerListState();
}

class _EmpManagerListState extends State<EmpManagerList> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    if (widget.emps.isEmpty) {
      return Center(child: Text(locale.no_result));
    }

    return ListView(children: widget.emps.map((emp) => EmpTile(emp)).toList());
  }
}
