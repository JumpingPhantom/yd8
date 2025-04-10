import 'package:equatable/equatable.dart';

import '../../domain/types.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateTheme extends SettingsEvent {
  final AppTheme appTheme;

  const UpdateTheme({required this.appTheme});

  @override
  List<Object> get props => [appTheme];
}

class UpdateLanguage extends SettingsEvent {
  final String languageCode;

  const UpdateLanguage({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}
