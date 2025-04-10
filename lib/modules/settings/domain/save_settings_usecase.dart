import '../../../core/common/types.dart';
import 'entities.dart';
import 'settings_repo.dart';

class SaveSettingsUsecase extends Usecase<Result<Settings>, Settings> {
  final SettingsRepo settingsRepo;

  SaveSettingsUsecase(this.settingsRepo);

  @override
  Future<Result<Settings>> call(Settings config) => settingsRepo.save(config);
}
