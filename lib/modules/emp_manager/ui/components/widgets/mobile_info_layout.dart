import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'label_detail.dart';

class MobileInfoLayout extends StatelessWidget {
  final Emp emp;

  const MobileInfoLayout(this.emp, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;

    const double verticalSpacing = 16.0;
    const double horizontalPadding = 20.0;
    const double verticalPadding = 20.0;

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      children: [
        // Profile Section
        Center(
          child: CircleAvatar(
            radius: 56,
            backgroundColor: colorScheme.secondaryContainer,
            child: Icon(
              Icons.person_outline,
              size: 64,
              color: colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(height: verticalSpacing),
        Center(
          child: Text(
            '${emp.firstName} ${emp.lastName}'.trim(),
            style: textTheme.headlineSmall?.copyWith(
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
        const Divider(),
        const SizedBox(height: verticalSpacing),

        // Contact Information
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
        const Divider(),
        const SizedBox(height: verticalSpacing),

        // Employment Details
        _buildDetailSection(
          context,
          title: locale.employment_info,
          children: [
            LabelDetail(label: locale.department, detail: emp.department),
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
        const SizedBox(height: verticalSpacing),
        const Divider(),
        const SizedBox(height: verticalSpacing),

        // Additional Information
        Text(
          locale.additional_info,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ), // Section title
        ),
        const SizedBox(height: verticalSpacing / 2),
        if (emp.attr.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(locale.empty, style: textTheme.bodyMedium),
          )
        else
          ...emp.attr.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: verticalSpacing / 1.5),
              child: LabelDetail(
                label: entry.key,
                detail: entry.value?.toString() ?? 'N/A',
              ),
            ),
          ),
        const SizedBox(height: verticalPadding),
      ],
    );
  }

  Widget _buildDetailSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20 / 2),
        ...children,
      ],
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
