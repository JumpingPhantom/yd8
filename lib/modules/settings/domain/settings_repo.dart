import '../../../core/common/types.dart';
import 'entities.dart';

abstract class SettingsRepo {
  /// Loads the settings.
  ///
  /// Returns a [Result] containing either the loaded [Settings] or an error.
  Future<Result<Settings>> load();

  /// Saves the settings configuration.
  ///
  /// The configuration is provided as Settings.
  /// Returns a [Result] indicating success or failure of the save operation.
  Future<Result<Settings>> save(Settings config);
}
