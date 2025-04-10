import 'package:flutter/material.dart';
import '../../domain/entities.dart';
import 'widgets/desktop_info_layout.dart';
import 'widgets/info_app_bar.dart';
import 'widgets/mobile_info_layout.dart';

import '../shared/types.dart';

class EmpInfoDialog extends StatelessWidget {
  final Emp emp;
  final Function() onEditEmp;
  final Function() onDeleteEmp;

  const EmpInfoDialog(
    this.emp, {
    super.key,
    required this.onEditEmp,
    required this.onDeleteEmp,
  });

  void _handleMenuActionSelected(MenuAction item) {
    switch (item) {
      case MenuAction.edit:
        // TODO: Handle this case.
        onEditEmp();
        throw UnimplementedError();
      case MenuAction.delete:
        onDeleteEmp();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: InfoAppBar(onMenuActionSelected: _handleMenuActionSelected),
        body:
            MediaQuery.sizeOf(context).width < 600
                ? MobileInfoLayout(emp)
                : DesktopInfoLayout(emp),
      ),
    );
  }
}
