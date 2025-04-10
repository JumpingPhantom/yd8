import 'package:equatable/equatable.dart';

import 'types.dart';

abstract class Settings extends Equatable {
  final AppTheme appTheme;
  final String language;

  const Settings({required this.appTheme, required this.language});

  @override
  List<Object?> get props => [appTheme, language];
}

class SettingsImpl extends Settings {
  const SettingsImpl({required super.appTheme, required super.language});
}
