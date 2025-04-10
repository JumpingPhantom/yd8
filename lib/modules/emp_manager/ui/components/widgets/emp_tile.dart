import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/types.dart';
import '../../../domain/entities.dart';
import '../../../domain/types.dart';
import '../../bloc/emp_manager.event.dart';
import '../../bloc/emp_manager_bloc.dart';
import '../emp_info_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmpTile extends StatelessWidget {
  final Emp emp;

  const EmpTile(this.emp, {super.key});

  @override
  Widget build(BuildContext context) {
    final empBloc = context.read<EmpManagerBloc>();
    final locale = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: CircleAvatar(
        child: Text(
          '${emp.firstName[0]}${emp.lastName[0]}'.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        '${emp.firstName} ${emp.lastName}',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emp.department,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  emp.gender == Gender.male.name
                      ? Icons.male
                      : emp.gender == Gender.female.name
                      ? Icons.female
                      : Icons.person,
                  size: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  emp.gender == Gender.male.name
                      ? locale.male
                      : emp.gender == Gender.female.name
                      ? locale.female
                      : locale.other,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Builder(
              builder: (context) {
                Color statusColor;
                IconData statusIcon;
                String statusText;

                switch (emp.status) {
                  case EmpStatus.active:
                    statusColor = Colors.green.shade700;
                    statusIcon = Icons.check_circle_outline;
                    statusText = locale.active;
                    break;
                  case EmpStatus.inactive:
                    statusColor = Colors.grey.shade600;
                    statusIcon = Icons.pause_circle_outline;
                    statusText = locale.inactive;
                    break;
                  case EmpStatus.suspended:
                    statusColor = Colors.amber.shade800;
                    statusIcon = Icons.warning_amber_outlined;
                    statusText = locale.suspended;
                    break;
                  case EmpStatus.terminated:
                    statusColor = Colors.red.shade700;
                    statusIcon = Icons.cancel_outlined;
                    statusText = locale.terminated;
                    break;
                }

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: 20),
      onTap: () {
        showDialog(
          context: context,
          builder:
              (_) => EmpInfoDialog(
                emp,
                onEditEmp: () {
                  Navigator.of(context).pop();
                },
                onDeleteEmp: () {
                  empBloc.add(RemEmp(id: emp.id!));
                  Navigator.of(context).pop();
                },
              ),
        );
      },
    );
  }
}
