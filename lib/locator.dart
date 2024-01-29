
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/presentation/bloc/bottom_nav_bar_cubit.dart';
import 'features/home/presentation/bloc/home_cubit.dart';
import 'features/splash/presentation/bloc/splash_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //BLOC

  locator.registerFactory(() => BottomNavBarCubit());
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => SplashCubit());

  // //USECASES
  // locator.registerLazySingleton(() => AuthUseCase(locator()));

  // //CORE
  // locator.registerLazySingleton(() => NetworkInfoImpl(locator()));

  // //REPOSITORISE
  // locator.registerLazySingleton<AuthRepository>(
  //     () => AuthImplRepository(authService: locator(), cacheHelper: locator()));


  // //DATASOURSE
  // locator.registerLazySingleton(() => ApiServiceAuth());

  // //EXTRNAL
  locator.registerLazySingleton(() => SharedPreferences.getInstance());
}
