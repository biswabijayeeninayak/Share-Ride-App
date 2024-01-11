class NotificationModel {
  final int id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final String data;
  final String? readAt; // Make readAt nullable
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    this.readAt, // Make readAt nullable
    required this.createdAt,
    required this.updatedAt,
  });
}
