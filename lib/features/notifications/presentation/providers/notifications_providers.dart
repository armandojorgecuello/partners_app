import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:partners_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:partners_app/features/notifications/domain/entities/app_notification.dart';
import 'package:partners_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';

final notificationRemoteDataSourceProvider = Provider(
  (ref) => NotificationRemoteDataSource(ref.watch(firestoreProvider)),
);

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepositoryImpl(ref.watch(notificationRemoteDataSourceProvider)),
);

final notificationsProvider = StreamProvider.family<List<AppNotification>, String>(
  (ref, uid) => ref.watch(notificationRepositoryProvider).watchNotifications(uid),
);

final sendNotificationUseCaseProvider = Provider(
  (ref) => SendNotificationUseCase(ref.watch(notificationRepositoryProvider)),
);
