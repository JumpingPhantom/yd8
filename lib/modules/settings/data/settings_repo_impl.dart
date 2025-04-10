import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../../core/common/types.dart';
import '../domain/entities.dart';
import '../domain/settings_repo.dart';
import '../domain/types.dart';
import 'models.dart';

class SettingsRepoImpl implements SettingsRepo {
  @override
  Future<Result<Settings>> load() async {
    Directory dir = await getApplicationSupportDirectory();

    File file = File('${dir.path}/settings.json');

    if (!await file.exists()) {
      final defaultSettings = SettingsModel(
        appTheme: AppTheme.system,
        language: 'en-US',
      );

      await file.create();
      await file.writeAsString(jsonEncode(defaultSettings));
      return Ok(defaultSettings);
    }

    String content = await file.readAsString();
    Settings settings = SettingsModel.fromJson(jsonDecode(content));

    return Ok(settings);
  }

  @override
  Future<Result<Settings>> save(Settings config) async {
    Directory dir = await getApplicationSupportDirectory();
    File file = File('${dir.path}/settings.json');

    if (!await file.exists()) {
      return Err(
        Exception(
          'error saving file, could not locate configuration file, please create one',
        ),
      );
    }

    final model = SettingsModel(
      appTheme: config.appTheme,
      language: config.language,
    );

    await file.writeAsString(jsonEncode(model.toJson()));

    return Ok(config);
  }
}
