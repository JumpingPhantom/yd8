import '../domain/entities.dart';
import '../domain/types.dart';

class SettingsModel extends Settings {
  const SettingsModel({required super.appTheme, required super.language});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      appTheme: AppTheme.values.firstWhere(
        (theme) => theme.name == json['theme'],
      ),
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'theme': appTheme.name, 'language': language};
  }

  @override
  List<Object?> get props => [appTheme, language];
}
