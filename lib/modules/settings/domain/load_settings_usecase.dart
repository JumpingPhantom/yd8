import '../../../core/common/types.dart';
import 'entities.dart';
import 'settings_repo.dart';

class LoadSettingsUsecase extends Usecase<Result<Settings>, void> {
  final SettingsRepo settingsRepo;

  LoadSettingsUsecase(this.settingsRepo);

  @override
  Future<Result<Settings>> call(void params) => settingsRepo.load();
}
