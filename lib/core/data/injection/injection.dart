import 'dart:async';

import 'package:baca_meter/core/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/auth/auth_repository.dart';
import '../../presentation/manager/database_helper.dart';
import '../../presentation/manager/local_database_service.dart';
import '../../presentation/page/auth/login/provider/login_notifier.dart';
import '../../presentation/utilities/internet_connectivity_provider.dart';

import '../database/app_database.dart';
import '../repositories_impl/auth/auth_repository_impl.dart';
import '../utilities/network/dio_handler.dart';

final sl = GetIt.instance;

class Injection {
  // Initialize all injection
  Future init() async {
    // Utilities
    await _registerPreferences();
    await _registerDio();
    await _registerDataSources();
    await _registerHelper();
    // await _registerAuth();
    // await _registerManager();

    // Repositories
    await _registerRepository();

    // Notifiers
    await _registerAuthNotifier();

    // Usecases
    // await _registerAuthUseCases();

    // Database
    await _registerDatabase(); // ✅ DB
  }

  Future _registerPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
  }

  Future _registerDio() async {
    sl.registerLazySingleton<DioHandler>(
      () => DioHandler(sharedPreferences: sl()),
    );
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
  }

  Future _registerDataSources() async {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: sl()),
    );
  }

  // Future _registerAuthUseCases() async {
  //   sl.registerFactory(() => LoginUseCase(authRepository: sl()));
  // }

  Future _registerRepository() async {
    // Auth
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: sl(),
        // googleAuthDataSource: sl(),
        // facebookAuthDataSource: sl(),
        // appleAuthDataSource: sl(),
      ),
    );
  }

  Future _registerAuthNotifier() async {
    // sl.registerFactory(() => LoginNotifier(sl()));
    sl.registerFactory(() => LoginNotifier());
    sl.registerFactory(() => InternetConnectionProvider());
  }

  Future _registerHelper() async {
    sl.registerLazySingleton(() => DeviceInfoPlugin());
    // sl.registerFactory<FirebaseMessaging>(() => FirebaseMessaging.instance);
    // sl.registerFactory<FlutterLocalNotificationsPlugin>(
    //   () => FlutterLocalNotificationsPlugin(),
    // );
  }

  // Future _registerAuth() async {
  //   sl.registerFactory<FirebaseAuth>(() => FirebaseAuth.instance);
  // }

  // Future _registerManager() async {
  //   sl.registerLazySingleton(() => FirebaseMessageManager());
  // }

  Future _registerDatabase() async {
    sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

    sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper(sl()));

    sl.registerLazySingleton<LocalDatabaseService>(
      () => LocalDatabaseService(sl()),
    );
  }
}
