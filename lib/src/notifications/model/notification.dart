class Notification {
  final String id;
  final String title;
  final String description;
  final String redirect;
  final bool isRead;
  final String date;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.redirect,
    required this.isRead,
    required this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      redirect: json['module_path'],
      isRead: json['is_read'] ? true : false,
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'redirect': redirect,
      'is_read': isRead,
      'date': date,
    };
  }
}