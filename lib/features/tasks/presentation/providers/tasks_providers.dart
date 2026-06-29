import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:partners_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:partners_app/features/tasks/data/datasources/task_storage_data_source.dart';
import 'package:partners_app/features/tasks/data/repositories/chat_repository_impl.dart';
import 'package:partners_app/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:partners_app/features/tasks/domain/entities/chat_message.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/repositories/chat_repository.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:partners_app/features/tasks/domain/usecases/create_task_usecase.dart';
import 'package:partners_app/features/tasks/domain/usecases/send_chat_message_usecase.dart';
import 'package:partners_app/features/tasks/domain/usecases/submit_review_usecase.dart';
import 'package:partners_app/features/tasks/domain/usecases/update_reward_image_usecase.dart';
import 'package:partners_app/features/tasks/domain/usecases/update_task_status_usecase.dart';

final taskRemoteDataSourceProvider = Provider(
  (ref) => TaskRemoteDataSource(ref.watch(firestoreProvider)),
);

final taskStorageDataSourceProvider = Provider(
  (ref) => TaskStorageDataSource(ref.watch(firebaseStorageProvider)),
);

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => TaskRepositoryImpl(ref.watch(taskRemoteDataSourceProvider), ref.watch(taskStorageDataSourceProvider)),
);

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepositoryImpl(ref.watch(taskRemoteDataSourceProvider)),
);

final tasksProvider = StreamProvider.family<List<Task>, String>(
  (ref, uid) => ref.watch(taskRepositoryProvider).watchTasks(uid),
);

final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>(
  (ref, taskId) => ref.watch(chatRepositoryProvider).watchMessages(taskId),
);

final createTaskUseCaseProvider = Provider(
  (ref) => CreateTaskUseCase(ref.watch(taskRepositoryProvider), ref.watch(sendNotificationUseCaseProvider)),
);

final updateTaskStatusUseCaseProvider = Provider(
  (ref) => UpdateTaskStatusUseCase(ref.watch(taskRepositoryProvider), ref.watch(sendNotificationUseCaseProvider)),
);

final submitReviewUseCaseProvider = Provider(
  (ref) => SubmitReviewUseCase(ref.watch(taskRepositoryProvider), ref.watch(sendNotificationUseCaseProvider)),
);

final sendChatMessageUseCaseProvider = Provider(
  (ref) => SendChatMessageUseCase(ref.watch(chatRepositoryProvider), ref.watch(sendNotificationUseCaseProvider)),
);

final updateRewardImageUseCaseProvider = Provider(
  (ref) => UpdateRewardImageUseCase(ref.watch(taskRepositoryProvider)),
);
