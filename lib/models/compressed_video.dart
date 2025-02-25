class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final String uploadTime;
  final String views;
  final String author;
  final String videoUrl;
  final String description;
  final String subscriber;
  final bool isLive;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.uploadTime,
    required this.views,
    required this.author,
    required this.videoUrl,
    required this.description,
    required this.subscriber,
    required this.isLive,
  });

  // Factory constructor to create a Video object from a JSON map
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      duration: json['duration'] as String,
      uploadTime: json['uploadTime'] as String,
      views: json['views'] as String,
      author: json['author'] as String,
      videoUrl: json['videoUrl'] as String,
      description: json['description'] as String,
      subscriber: json['subscriber'] as String,
      isLive: json['isLive'] as bool,
    );
  }

  // Method to convert Video object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'uploadTime': uploadTime,
      'views': views,
      'author': author,
      'videoUrl': videoUrl,
      'description': description,
      'subscriber': subscriber,
      'isLive': isLive,
    };
  }
}
