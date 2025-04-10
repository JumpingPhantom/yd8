import 'package:equatable/equatable.dart';

import '../../domain/types.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final AppTheme appTheme;
  final String languageCode;

  const SettingsLoaded({required this.appTheme, required this.languageCode});

  @override
  List<Object> get props => [appTheme, languageCode];

  SettingsLoaded copyWith({AppTheme? appTheme, String? languageCode}) {
    return SettingsLoaded(
      appTheme: appTheme ?? this.appTheme,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError({required this.message});

  @override
  List<Object> get props => [message];
}
