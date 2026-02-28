import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:traffic_app/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:traffic_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:traffic_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:traffic_app/features/exam/data/datasources/exam_remote_data_source.dart';
import 'package:traffic_app/features/exam/domain/repositories/exam_repository.dart';
import 'package:traffic_app/features/license/data/repositories/license_repository_impl.dart';
import 'package:traffic_app/features/license/domain/usecases/get_categories_usecase.dart';

import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/exam/data/repositories/exam_repository_impl.dart';
import 'features/exam/domain/usecases/calculate_score.dart';
import 'features/exam/domain/usecases/get_exam_detail.dart';
import 'features/exam/domain/usecases/get_exams_by_type.dart';
import 'features/exam/domain/usecases/get_random_exam.dart';
import 'features/exam/presentation/bloc/exam_detail/exam_detail_bloc.dart';
import 'features/exam/presentation/bloc/exam_total/exam_bloc.dart';
import 'features/license/data/datasources/license_remote_data_source.dart';
import 'features/license/domain/repositories/license_repository.dart';
import 'features/license/presentation/bloc/license_bloc.dart';
import 'features/traffic_sign/data/datasources/traffic_sign_remote_data_source.dart';
import 'features/traffic_sign/data/repositories/traffic_sign_repository_impl.dart';
import 'features/traffic_sign/domain/repositories/traffic_sign_repository.dart';
import 'features/traffic_sign/domain/usecases/get_traffic_sign_categories.dart';
import 'features/traffic_sign/domain/usecases/get_traffic_signs_by_group.dart';
import 'features/traffic_sign/presentation/bloc/category/traffic_sign_category_bloc.dart';
import 'features/traffic_sign/presentation/bloc/list/traffic_sign_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://traffic-api.up.railway.app/api/v1',
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
      ),
    ),
  );
  //--Auth--
  //Datasources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  //Repo
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  //Usecases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));

  //--License
  //Datasources
  sl.registerLazySingleton<LicenseRemoteDataSource>(
    () => LicenseRemoteDataSourceImpl(dio: sl()),
  );
  //Repo
  sl.registerLazySingleton<LicenseRepository>(
    () => LicenseRepositoryImpl(remoteDataSource: sl()),
  );
  //Usecases
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));

  //--Exam
  //Datasources
  sl.registerLazySingleton<ExamRemoteDataSource>(
    () => ExamRemoteDataSourceImpl(dio: sl()),
  );
  //Repo
  sl.registerLazySingleton<ExamRepository>(
    () => ExamRepositoryImpl(remoteDataSource: sl()),
  );
  //Usecases
  sl.registerLazySingleton(() => GetExamsByType(sl()));
  sl.registerLazySingleton(() => GetExamDetail(sl()));
  sl.registerLazySingleton(() => SubmitExam(sl()));
  sl.registerLazySingleton(() => GetRandomExam(sl()));

  //-- Traffic Sign --
  // Datasources
  sl.registerLazySingleton<TrafficSignRemoteDataSource>(
    () => TrafficSignRemoteDataSourceImpl(dio: sl()),
  );
  // Repo
  sl.registerLazySingleton<TrafficSignRepository>(
    () => TrafficSignRepositoryImpl(remoteDataSource: sl()),
  );
  // Usecases
  sl.registerLazySingleton(() => GetTrafficSignCategories(sl()));
  sl.registerLazySingleton(() => GetTrafficSignsByGroup(sl()));

  //Bloc
  sl.registerFactory(
    () => AuthBloc(
      registerUseCase: sl(),
      loginUseCase: sl(),
      verifyOtpUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );
  sl.registerFactory(() => LicenseBloc(getCategoriesUseCase: sl()));
  sl.registerFactory(() => ExamBloc(getExamsByType: sl()));
  sl.registerFactory(
    () => ExamDetailBloc(
      getExamDetail: sl(),
      submitExam: sl(),
      getRandomExam: sl(),
    ),
  );
  sl.registerFactory(
    () => TrafficSignCategoryBloc(getTrafficSignCategories: sl()),
  );
  sl.registerFactory(() => TrafficSignListBloc(getTrafficSignsByGroup: sl()));
}
