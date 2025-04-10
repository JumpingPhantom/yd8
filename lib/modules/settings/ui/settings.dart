import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/nav.dart';
import '../domain/types.dart';
import 'bloc/settings_bloc.dart';

import '../../../core/common/util.dart';
import 'bloc/settings_event.dart';

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
    return BlocProvider<SettingsBloc>(
      create: (_) => sl(),
      child: AppScaffold(
        title: 'Settings',
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
                        ListTile(
                          title: const Text('Theme'),
                          trailing: ToggleButtons(
                            isSelected: [
                              state.appTheme == AppTheme.light,
                              state.appTheme == AppTheme.dark,
                              state.appTheme == AppTheme.system,
                            ],
                            onPressed: (int index) {
                              AppTheme selectedTheme;
                              switch (index) {
                                case 0:
                                  selectedTheme = AppTheme.light;
                                  widget.onThemeModeChanged(ThemeMode.light);
                                  break;
                                case 1:
                                  selectedTheme = AppTheme.dark;
                                  widget.onThemeModeChanged(ThemeMode.dark);
                                  break;
                                case 2:
                                default:
                                  selectedTheme = AppTheme.system;
                                  widget.onThemeModeChanged(ThemeMode.system);
                                  break;
                              }
                              bloc.add(UpdateTheme(appTheme: selectedTheme));
                            },
                            borderRadius: BorderRadius.circular(8.0),
                            constraints: const BoxConstraints(minHeight: 40.0),
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.light_mode, size: 18),
                                    SizedBox(width: 4),
                                    Text('Light'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.dark_mode, size: 18),
                                    SizedBox(width: 4),
                                    Text('Dark'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.settings_system_daydream_outlined,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text('System'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: const Text('Language'),
                          trailing: ToggleButtons(
                            isSelected: [
                              state.language == 'en-US',
                              state.language == 'ar-SA',
                            ],
                            onPressed: (int index) {
                              String selectedLocale;
                              switch (index) {
                                case 0:
                                  selectedLocale = 'en-US';
                                  widget.onLocaleChanged(Locale('en', 'US'));
                                  break;
                                case 1:
                                default:
                                  selectedLocale = 'ar-SA';
                                  widget.onLocaleChanged(Locale('ar', 'SA'));
                                  break;
                              }
                              bloc.add(
                                UpdateLanguage(languageCode: selectedLocale),
                              );
                            },
                            borderRadius: BorderRadius.circular(8.0),
                            constraints: const BoxConstraints(minHeight: 40.0),
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('English'), // Display name
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('العربية'), // Display name
                              ),
                            ],
                          ),
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
