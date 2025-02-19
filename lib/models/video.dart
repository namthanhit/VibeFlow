class Video {
  final String id;
  final String title;
  final String author;
  final Thumbnails thumbnails;

  Video({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnails,
  });
}

class Thumbnails {
  final String mediumResUrl;

  Thumbnails({required this.mediumResUrl});
}