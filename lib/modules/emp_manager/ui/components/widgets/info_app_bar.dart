import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/types.dart';

class InfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(MenuAction) onMenuActionSelected;

  const InfoAppBar({super.key, required this.onMenuActionSelected});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return AppBar(
      actions: [
        PopupMenuButton<MenuAction>(
          icon: const Icon(Icons.more_vert),
          onSelected: onMenuActionSelected,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<MenuAction>(
                value: MenuAction.edit,
                child: Text(locale.edit),
              ),
              PopupMenuItem<MenuAction>(
                value: MenuAction.delete,
                child: Text(locale.delete),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
