import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<List<Video>> searchVideos(String query) async {
    try {
      final searchResults = await _yt.search.search(query);
      return searchResults.take(10).toList(); // Lấy 10 kết quả đầu tiên
    } catch (e) {
      throw Exception('Lỗi tìm kiếm: $e');
    }
  }

  Future<String> getAudioUrl(String videoId) async {
    try {
      final streamManifest = await _yt.videos.streamsClient.getManifest(videoId);
      final audioStream = streamManifest.audioOnly.withHighestBitrate();
      return audioStream.url.toString();
    } catch (e) {
      throw Exception('Lỗi lấy URL phát nhạc: $e');
    }
  }

  void dispose() {
    _yt.close();
  }
}