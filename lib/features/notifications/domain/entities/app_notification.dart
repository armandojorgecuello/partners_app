class AppNotification {
  final String id;
  final String type;
  final String actorUid;
  final String? taskId;
  final String? status;
  final DateTime? dateTime;
  final bool read;

  const AppNotification({
    required this.id,
    required this.type,
    required this.actorUid,
    this.taskId,
    this.status,
    this.dateTime,
    this.read = false,
  });
}
