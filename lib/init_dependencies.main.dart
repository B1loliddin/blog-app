part of 'init_dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  /// Database
  final Supabase supabase = await Supabase.initialize(
    url: AppSecrets.supabaseProjectUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  /// Database
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  serviceLocator.registerLazySingleton<Box<dynamic>>(
    () => Hive.box(name: 'blogs'),
  );

  /// Core
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());

  serviceLocator.registerFactory<InternetConnection>(
    () => InternetConnection(),
  );

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );
}

void _initAuth() {
  // Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
  );

  // Use Case
  serviceLocator.registerFactory<UserSignUp>(
    () => UserSignUp(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory<UserSignIn>(
    () => UserSignIn(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory<GetCurrentUser>(
    () => GetCurrentUser(authRepository: serviceLocator()),
  );

  // Bloc
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      getCurrentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  // Data Source
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(box: serviceLocator()),
  );

  // Repository
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      blogRemoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
      blogLocalDataSource: serviceLocator(),
    ),
  );

  // Use Case
  serviceLocator.registerFactory<UploadBlog>(
    () => UploadBlog(blogRepository: serviceLocator()),
  );

  serviceLocator.registerFactory<GetAllBlogs>(
    () => GetAllBlogs(blogRepository: serviceLocator()),
  );

  // Bloc
  serviceLocator.registerLazySingleton<BlogBloc>(
    () => BlogBloc(
      uploadBlog: serviceLocator(),
      getAllBlogs: serviceLocator(),
    ),
  );
}
