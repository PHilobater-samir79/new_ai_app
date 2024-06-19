import 'package:get_it/get_it.dart';
import 'package:yab_yab_ai/core/local_data/catch_helper.dart';
final getIt = GetIt.instance;
 Future<void> setup()  async {
   getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
 }