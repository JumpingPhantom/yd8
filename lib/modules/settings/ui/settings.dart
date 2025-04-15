import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/nav.dart';
import 'bloc/settings_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/common/util.dart';
import 'bloc/settings_event.dart';
import 'components/language_selector.dart';
import 'components/theme_selector.dart';

class SettingsPage extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  final Function(ThemeMode) onThemeModeChanged;
  const SettingsPage({
    super.key,
    required this.onLocaleChanged,
    required this.onThemeModeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return BlocProvider<SettingsBloc>(
      create: (_) => sl(),
      child: AppScaffold(
        title: locale.settings,
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final bloc = context.read<SettingsBloc>();

            return Scaffold(
              appBar: AppBar(),
              body: Builder(
                builder: (_) {
                  if (state is SettingsInitial) {
                    bloc.add(LoadSettings());
                  } else if (state is SettingsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SettingsLoaded) {
                    return ListView(
                      children: [
                        ThemeSelector(
                          state: state,
                          onThemeModeChanged: widget.onThemeModeChanged,
                          onUpdate: (event) => bloc.add(event),
                        ),
                        LanguageSelector(
                          state: state,
                          onLocaleChanged: widget.onLocaleChanged,
                          onUpdate: (event) => bloc.add(event),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            );
          },
        ),
        currentRoute: '/settings',
      ),
    );
  }
}
