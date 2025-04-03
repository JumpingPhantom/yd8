import 'package:flutter/material.dart';
import 'package:yd8/core/common/ui/label_detail.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

enum MenuAction { edit, delete }

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [FlutterLogo(size: 128), Placeholder()],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Emp emp;
  const _DesktopLayout(this.emp);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 18,
              children: [
                const FlutterLogo(size: 128),
                Expanded(
                  child: Column(
                    spacing: 18.0,
                    children: [
                      Text(
                        emp.firstName,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      LabelDetail(label: 'Role', detail: emp.role),
                      LabelDetail(label: 'Department', detail: emp.department),
                      Column(
                        children:
                            emp.phone
                                .map(
                                  (phone) => LabelDetail(
                                    label: 'Phone',
                                    detail: phone,
                                  ),
                                )
                                .toList(),
                      ),
                      LabelDetail(label: 'Email', detail: emp.email),
                      LabelDetail(
                        label: 'Hire date',
                        detail: _getDate(emp.hireDate),
                      ),
                      LabelDetail(label: 'Gender', detail: emp.gender),
                      LabelDetail(label: 'Type', detail: emp.type.name),
                      LabelDetail(label: 'Status', detail: emp.status.name),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children:
                emp.attr.entries
                    .map(
                      (entry) => LabelDetail(
                        label: entry.key,
                        detail: entry.value.toString(),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }

  _getDate(String hireDate) {
    final date = DateTime.parse(hireDate);
    return '${date.month}/${date.day}/${date.year}';
  }
}

class EmpManagerEmpDetails extends StatelessWidget {
  final Emp emp;
  final Function(void) onEditEmp;
  final Function(void) onDeleteEmp;

  const EmpManagerEmpDetails(
    this.emp, {
    super.key,
    required this.onEditEmp,
    required this.onDeleteEmp,
  });

  void _handleMenuActionSelected(MenuAction item) {
    switch (item) {
      case MenuAction.edit:
        // TODO: Handle this case.
        onEditEmp(null);
        throw UnimplementedError();
      case MenuAction.delete:
        onDeleteEmp(null);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: EmpManagerDialogAppbar(
          menuItems: ['Edit', 'Delete'],
          onMenuActionSelected: _handleMenuActionSelected,
        ),
        body:
            MediaQuery.sizeOf(context).width < 600
                ? _MobileLayout()
                : _DesktopLayout(emp),
      ),
    );
  }
}

class EmpManagerDialogAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final List<String> menuItems;
  final Function(MenuAction) onMenuActionSelected;

  const EmpManagerDialogAppbar({
    super.key,
    required this.menuItems,
    required this.onMenuActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        PopupMenuButton<MenuAction>(
          icon: const Icon(Icons.more_vert),
          onSelected: onMenuActionSelected,
          itemBuilder: (BuildContext context) {
            return MenuAction.values.map((item) {
              return PopupMenuItem<MenuAction>(
                value: item,
                child: Text(item.name),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
