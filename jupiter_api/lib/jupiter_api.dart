library jupiter_api;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jupiter_api/config/api/api_config.dart';

class JupiterApi {
  final getIt = GetIt.instance;

  JupiterApi({required this.env}) {
    // // usecase
    // getIt.registerLazySingleton(() => UserManagementUseCase(getIt()));

    // // repository
    // getIt.registerLazySingleton<UserManagementRepository>(
    //   () => UserManagementRepositoryImpl(getIt()),
    // );

    // final dio = DioUtil.createDioInstance(getBaseUrl(env));

    // // data source
    // getIt.registerLazySingleton<RestClient>(
    //   () => RestClient(dio),
    // );

    // // external
    // getIt.registerLazySingleton(() => Dio);
    ApiConfig.env = env;
  }

  final ENV env;
  static String getBaseUrl(ENV env) {
    debugPrint("getBaseUrlEnv $env");
    return env == ENV.dev ? ApiConfig.domainDev : ApiConfig.domainPrd;
  }
}
