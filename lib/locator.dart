import 'package:get_it/get_it.dart';

import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/core/services/post_service.dart';

import 'package:iconnect/core/view_models/feed_model.dart';
import 'package:iconnect/core/view_models/lostitem_model.dart';

import 'core/view_models/like_model.dart';

GetIt locator = GetIt.instance;

// void setupAuthSingleton() {
//   locator.registerLazySingleton(() => Auth());
// }

void setupDatbaseSingleton(String id) {
  if (!locator.isRegistered<Database>()) {
    locator.registerLazySingleton(
      () => Database(userId: id),
    );
  }
  registerPostService();
  registerFeedModel();
  registerLostItemModel();
 
  registerLikeModel();
}

void registerPostService() {
  if (locator.isRegistered<PostService>()) return;
  locator.registerLazySingleton(() => PostService());
}

void registerFeedModel() {
  if (locator.isRegistered<FeedModel>()) return;
  locator.registerFactory(() => FeedModel());
}

void registerLostItemModel() {
  if (locator.isRegistered<LostItemModel>()) return;
  locator.registerFactory(() => LostItemModel());
}

void registerLikeModel() {
  if (locator.isRegistered<LikeModel>()) return;
  locator.registerFactory(() => LikeModel());
}


void unregisterDatabase() {
  locator.unregister<Database>();
}

void removeDatabaseSingleton() {
  locator.unregister<Database>();
}
