class EventModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
