import 'package:get_it/get_it.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/auth/data/repository/auth_repo_imp.dart';
import 'package:real_estate/features/auth/data/source/auth_service.dart';
import 'package:real_estate/features/auth/domain/repository/auth_repo.dart';
import 'package:real_estate/features/auth/domain/usecase/login.dart';
import 'package:real_estate/features/auth/domain/usecase/sendCode.dart';
import 'package:real_estate/features/auth/domain/usecase/signup.dart';
import 'package:real_estate/features/auth/domain/usecase/verify_code.dart';
import 'package:real_estate/features/favorite/data/repository/favorite_repo_imp.dart';
import 'package:real_estate/features/favorite/data/source/favorite_api_service.dart';
import 'package:real_estate/features/favorite/domain/repository/favorite_repo.dart';
import 'package:real_estate/features/favorite/domain/usecase/favorite_usecase.dart';
import 'package:real_estate/features/favorite/presentation/bloc/getFavoriteUser/get_favorite_user_cubit.dart';
import 'package:real_estate/features/property/data/repository/property_repo_imp.dart';
import 'package:real_estate/features/property/data/source/property_api_service.dart';
import 'package:real_estate/features/property/domain/repository/property_repo.dart';
import 'package:real_estate/features/property/domain/usecase/property_usecase.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/propertyType/data/repository/property_type_repo_imp.dart';
import 'package:real_estate/features/propertyType/data/source/property_type_apiservice.dart';
import 'package:real_estate/features/propertyType/domain/repository/property_type_repo.dart';
import 'package:real_estate/features/propertyType/domain/usecase/property_type_usecase.dart';
import 'package:real_estate/features/propertyType/presentation/bloc/property_type_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<PropertyTypeApiService>(PropertyTypeApiServiceImp());
  sl.registerSingleton<PropertyApiService>(PropertyApiServiceImp());
  sl.registerSingleton<FavoriteApiService>(FavoriteApiServiceImp());



  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );
  sl.registerSingleton<PropertyTypeRepository>(
    PropertyTypeRepositoryImpl(sl<PropertyTypeApiService>()),
  );

  sl.registerSingleton<PropertyRepository>(
    PropertyRepositoryImpl(sl<PropertyApiService>()),
  );

  sl.registerSingleton<FavoriteRepository>(
    FavoriteRepositoryImpl(sl<FavoriteApiService>()),
  );

  // Usecases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase());
  sl.registerLazySingleton<SendCodeUseCase>(() => SendCodeUseCase());
  sl.registerLazySingleton<VerifyCodeUseCase>(() => VerifyCodeUseCase());
  sl.registerLazySingleton<PropertyTypeUseCase>(() => PropertyTypeUseCase());
  sl.registerLazySingleton<PropertyUseCase>(() => PropertyUseCase());
  sl.registerLazySingleton<GetFavoritesByUserIdUseCase>(() => GetFavoritesByUserIdUseCase());



  // Cubits
  sl.registerFactory<PropertyTypeCubit>(
    () => PropertyTypeCubit(sl<PropertyTypeUseCase>()),
  );

   sl.registerFactory<GetpropertyCubit>(
    () => GetpropertyCubit(sl<PropertyUseCase>()),
  );

  sl.registerFactory<GetFavoriteUserCubit>(
    () => GetFavoriteUserCubit(sl<GetFavoritesByUserIdUseCase>()),
  );
}