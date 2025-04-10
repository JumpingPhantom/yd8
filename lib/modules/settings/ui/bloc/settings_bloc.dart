import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/common/types.dart';
import '../../domain/entities.dart';
import '../../domain/load_settings_usecase.dart';
import '../../domain/save_settings_usecase.dart';
import '../../domain/types.dart';
import 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SaveSettingsUsecase saveSettingsUsecase;
  final LoadSettingsUsecase loadSettingsUsecase;

  SettingsBloc(this.saveSettingsUsecase, this.loadSettingsUsecase)
    : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateTheme>(_onUpdateTheme);
    on<UpdateLanguage>(_onUpdateLanguage);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    Result<Settings> settings = await loadSettingsUsecase(null);

    if (settings is Err) {
      emit(SettingsError(message: 'failed to load settings'));
      return;
    }

    Settings config = settings.data!;

    emit(SettingsLoaded(language: config.language, appTheme: config.appTheme));
  }

  Future<void> _onUpdateTheme(
    UpdateTheme event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(SettingsLoading());

      final res = await saveSettingsUsecase(
        SettingsImpl(appTheme: event.appTheme, language: currentState.language),
      );

      if (res is Err) {
        emit(SettingsError(message: 'failed to save settings'));
        return;
      }

      emit(
        SettingsLoaded(
          appTheme: event.appTheme,
          language: currentState.language,
        ),
      );
    }
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(SettingsLoading());

      final res = await saveSettingsUsecase(
        SettingsImpl(
          appTheme: currentState.appTheme,
          language: event.languageCode,
        ),
      );

      if (res is Err) {
        emit(SettingsError(message: 'failed to save settings'));
        return;
      }

      emit(
        SettingsLoaded(
          appTheme: currentState.appTheme,
          language: event.languageCode,
        ),
      );
    }
  }
}

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final AppTheme appTheme;
  final String language;

  const SettingsLoaded({required this.appTheme, required this.language});

  @override
  List<Object> get props => [appTheme, language];

  SettingsLoaded copyWith({AppTheme? appTheme, String? language}) {
    return SettingsLoaded(
      appTheme: appTheme ?? this.appTheme,
      language: language ?? this.language,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError({required this.message});

  @override
  List<Object> get props => [message];
}
