import 'package:get_it/get_it.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/appoinment/data/repository/appointment_repo_impl.dart';
import 'package:real_estate/features/appoinment/data/source/appointment_apiservice.dart';
import 'package:real_estate/features/appoinment/domain/repository/appointment_repo.dart';
import 'package:real_estate/features/appoinment/domain/usecase/create_appointment_usecase.dart';
import 'package:real_estate/features/appoinment/presentation/bloc/createAppointment/create_appointment_cubit.dart';
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
import 'package:real_estate/features/favorite/domain/usecase/toggle_favorite_usecase.dart';
import 'package:real_estate/features/favorite/domain/usecase/favorite_usecase.dart';
import 'package:real_estate/features/favorite/presentation/bloc/getFavoriteUser/get_favorite_user_cubit.dart';
import 'package:real_estate/features/favorite/presentation/bloc/toggleFavorite/toggle_favorite_cubit.dart';
import 'package:real_estate/features/location/data/repository/location_repo_impl.dart';
import 'package:real_estate/features/location/data/source/location_apiservice.dart';
import 'package:real_estate/features/location/domain/repository/location_repo.dart';
import 'package:real_estate/features/location/domain/usecase/location_usecase.dart';
import 'package:real_estate/features/location/presentation/bloc/getlocation/getlocation_cubit.dart';
import 'package:real_estate/features/notification/data/repository/notification_repo_impl.dart';
import 'package:real_estate/features/notification/data/source/notification_apiservice.dart';
import 'package:real_estate/features/notification/domain/repository/notification_repo.dart';
import 'package:real_estate/features/notification/domain/usecase/get_all_notification_usecase.dart';
import 'package:real_estate/features/notification/presentation/bloc/get_notification/get_notification_cubit.dart';
import 'package:real_estate/features/profile/data/repository/profile_repo_impl.dart';
import 'package:real_estate/features/profile/data/source/profile_api_service.dart';
import 'package:real_estate/features/profile/domain/repository/profile_repo.dart';
import 'package:real_estate/features/profile/domain/usecase/profile_usecase.dart';
import 'package:real_estate/features/profile/presentation/bloc/get_userby_id/get_userby_id_cubit.dart';
import 'package:real_estate/features/property/data/repository/property_repo_imp.dart';
import 'package:real_estate/features/property/data/source/property_api_service.dart';
import 'package:real_estate/features/property/domain/repository/property_repo.dart';
import 'package:real_estate/features/property/domain/usecase/create_property_usecase.dart';
import 'package:real_estate/features/property/domain/usecase/property_details_usecase.dart';
import 'package:real_estate/features/property/domain/usecase/property_usecase.dart';
import 'package:real_estate/features/property/presentation/bloc/createproperty/createproperty_cubit.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/property/presentation/bloc/propertyDetails/property_details_cubit.dart';
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
  sl.registerSingleton<LocationApiService>(LocationApiServiceImp());
   sl.registerSingleton<ProfileApiService>(ProfileApiServiceImp());
   sl.registerSingleton<AppointmentApiservice>(AppointmentApiserviceImpl());
    sl.registerSingleton<NotificationApiService>(NotificationApiServiceImp());





  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(),);
  sl.registerSingleton<PropertyTypeRepository>(PropertyTypeRepositoryImpl(sl<PropertyTypeApiService>()),);
  sl.registerSingleton<PropertyRepository>(PropertyRepositoryImpl(sl<PropertyApiService>()),);
  sl.registerSingleton<FavoriteRepository>(FavoriteRepositoryImpl(sl<FavoriteApiService>()),);
  sl.registerSingleton<LocationRepository>(LocationRepositoryImpl(sl<LocationApiService>()),);
  sl.registerSingleton<ProfileRepository>(UserRepositoryImpl(sl<ProfileApiService>()));
  sl.registerSingleton<AppointmentRepo>(AppointmentRepoImpl(sl<AppointmentApiservice>()));
    sl.registerSingleton<NotificationRepository>(NotificationRepositoryImpl(sl<NotificationApiService>()));




  // Usecases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase());
  sl.registerLazySingleton<SendCodeUseCase>(() => SendCodeUseCase());
  sl.registerLazySingleton<VerifyCodeUseCase>(() => VerifyCodeUseCase());
  sl.registerLazySingleton<PropertyTypeUseCase>(() => PropertyTypeUseCase());
  sl.registerLazySingleton<PropertyUseCase>(() => PropertyUseCase());
  sl.registerLazySingleton<GetFavoritesByUserIdUseCase>(() => GetFavoritesByUserIdUseCase());
  sl.registerLazySingleton<LocationUseCase>(() => LocationUseCase());
  sl.registerLazySingleton<CreatePropertyUseCase>(() => CreatePropertyUseCase());
  sl.registerLazySingleton<GetUserByIdUseCase>(() => GetUserByIdUseCase());
  sl.registerLazySingleton<ToggleFavoriteUseCase>(() => ToggleFavoriteUseCase());
  sl.registerLazySingleton<PropertyDetailsUseCase>(() => PropertyDetailsUseCase());
  sl.registerLazySingleton<CreateAppointmentUseCase>(() => CreateAppointmentUseCase());
  sl.registerLazySingleton<NotificationUseCase>(() => NotificationUseCase());
  
  // Cubits
  sl.registerFactory<PropertyTypeCubit>(() => PropertyTypeCubit(sl<PropertyTypeUseCase>()),);
   sl.registerFactory<GetpropertyCubit>(() => GetpropertyCubit(sl<PropertyUseCase>()),);
  sl.registerFactory<GetFavoriteUserCubit>(() => GetFavoriteUserCubit(sl<GetFavoritesByUserIdUseCase>()),);
  sl.registerFactory<GetlocationCubit>(() => GetlocationCubit(sl<LocationUseCase>()),);
   sl.registerFactory<CreatepropertyCubit>(() => CreatepropertyCubit(sl<CreatePropertyUseCase>()),);
  sl.registerFactory<GetUserbyIdCubit>(() => GetUserbyIdCubit(sl<GetUserByIdUseCase>()),);
  sl.registerFactory<ToggleFavoriteCubit>(() => ToggleFavoriteCubit(sl<ToggleFavoriteUseCase>()),);
  sl.registerFactory<PropertyDetailsCubit>(() => PropertyDetailsCubit(sl<PropertyDetailsUseCase>()),);
   sl.registerFactory<CreateappointmentCubit>(() => CreateappointmentCubit(sl<CreateAppointmentUseCase>()),);
   sl.registerFactory<GetNotificationCubit>(() => GetNotificationCubit(sl<NotificationUseCase>()),);
  
}