enum TaskStatus { notStarted, open, rejected, paidUpfront, reviewed }

extension TaskStatusMapping on TaskStatus {
  static TaskStatus fromRaw(String raw) => switch (raw) {
    'open' => TaskStatus.open,
    'rejected' => TaskStatus.rejected,
    'paid_upfront' => TaskStatus.paidUpfront,
    'reviewed' => TaskStatus.reviewed,
    _ => TaskStatus.notStarted,
  };

  String get raw => switch (this) {
    TaskStatus.notStarted => 'not_started',
    TaskStatus.open => 'open',
    TaskStatus.rejected => 'rejected',
    TaskStatus.paidUpfront => 'paid_upfront',
    TaskStatus.reviewed => 'reviewed',
  };
}
