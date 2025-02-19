import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:vibe_flow/services/audio_player_service.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Video video;

  const MusicPlayerScreen({super.key, required this.video});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _playAudio();
  }

  Future<void> _playAudio() async {
    try {
      final yt = YoutubeExplode();
      final streamManifest = await yt.videos.streamsClient.getManifest(widget.video.id);
      final audioStream = streamManifest.audioOnly.withHighestBitrate();

      await _audioPlayerService.playAudio(audioStream.url.toString());
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print('Lỗi phát nhạc: $e');
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayerService.pauseAudio();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.video.thumbnails.mediumResUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              widget.video.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.video.author,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {
                    // Chuyển bài trước
                  },
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (_isPlaying) {
                      _pauseAudio();
                    } else {
                      _playAudio();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    // Chuyển bài tiếp theo
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}