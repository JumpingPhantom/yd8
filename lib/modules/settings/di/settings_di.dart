import '../../../core/common/util.dart';
import '../data/settings_repo_impl.dart';
import '../domain/load_settings_usecase.dart';
import '../domain/save_settings_usecase.dart';
import '../domain/settings_repo.dart';
import '../ui/bloc/settings_bloc.dart';

void initSettingsDependencies() {
  // repo
  sl.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl());

  // usecases
  sl.registerLazySingleton(() => LoadSettingsUsecase(sl()));
  sl.registerLazySingleton(() => SaveSettingsUsecase(sl()));

  // blocs
  sl.registerFactory(() => SettingsBloc(sl(), sl()));
}
