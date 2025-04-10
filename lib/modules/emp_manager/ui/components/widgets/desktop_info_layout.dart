import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'label_detail.dart';

class DesktopInfoLayout extends StatelessWidget {
  final Emp emp;
  const DesktopInfoLayout(this.emp, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    const double verticalSpacing = 16.0;
    const double horizontalPadding = 24.0;
    const double verticalPadding = 20.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              horizontalPadding / 2,
              verticalPadding,
              horizontalPadding / 2,
              verticalPadding,
            ),
            child: ListView(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    child: Icon(
                      Icons
                          .person_outline, // TODO: change this to match the list two letter style
                      size: 72,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    // TODO: Replace with actual employee image if available
                  ),
                ),
                const SizedBox(height: verticalSpacing * 1.5),
                Center(
                  child: Text(
                    '${emp.firstName} ${emp.lastName}'.trim(),
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: verticalSpacing / 2),
                Center(
                  child: Text(
                    emp.role,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: verticalSpacing * 1.5),
                const Divider(indent: 16, endIndent: 16),
                const SizedBox(height: verticalSpacing),

                _buildDetailSection(
                  context,
                  title: locale.contact_info,
                  children: [
                    LabelDetail(label: locale.email, detail: emp.email),
                    const SizedBox(height: verticalSpacing / 1.5),
                    if (emp.phone.isNotEmpty) ...[
                      for (int i = 0; i < emp.phone.length; i++) ...[
                        Padding(
                          padding: EdgeInsets.only(left: i > 0 ? 16.0 : 0.0),
                          child: LabelDetail(
                            label: i == 0 ? locale.phone : '',
                            detail: emp.phone[i],
                          ),
                        ),
                        if (i < emp.phone.length - 1)
                          const SizedBox(height: verticalSpacing / 2),
                      ],
                    ],
                  ],
                ),
                const SizedBox(height: verticalSpacing),
                _buildDetailSection(
                  context,
                  title: locale.employment_info,
                  children: [
                    LabelDetail(
                      label: locale.department,
                      detail: emp.department,
                    ),
                    const SizedBox(height: verticalSpacing / 1.5),
                    LabelDetail(
                      label: locale.hiring_date,
                      detail: _formatDate(emp.hireDate),
                    ),
                    const SizedBox(height: verticalSpacing / 1.5),
                    LabelDetail(label: locale.type, detail: emp.type.name),
                    const SizedBox(height: verticalSpacing / 1.5),
                    LabelDetail(label: locale.status, detail: emp.status.name),
                    const SizedBox(height: verticalSpacing / 1.5),
                    LabelDetail(label: locale.gender, detail: emp.gender),
                  ],
                ),
                const SizedBox(height: verticalPadding),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.additional_info, style: textTheme.titleLarge),
                const SizedBox(height: verticalSpacing / 2),
                const Divider(),
                const SizedBox(height: verticalSpacing),
                Expanded(
                  child: ListView.separated(
                    itemCount: emp.attr.entries.length,
                    separatorBuilder:
                        (context, index) =>
                            const SizedBox(height: verticalSpacing),
                    itemBuilder: (context, index) {
                      final entry = emp.attr.entries.elementAt(index);
                      return LabelDetail(
                        label: entry.key,
                        detail: entry.value?.toString() ?? 'N/A',
                      );
                    },
                  ),
                ),
                const SizedBox(height: verticalPadding),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...children],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat.yMd().format(date);
    } catch (e) {
      return dateString;
    }
  }
}
