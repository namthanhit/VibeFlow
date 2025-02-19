import 'package:flutter/material.dart';
import 'package:vibe_flow/services/youtube_service.dart';
import 'package:vibe_flow/ui/search/music_player_screen.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final YoutubeService _youtubeService = YoutubeService();
  final TextEditingController _searchController = TextEditingController();
  List<Video> _searchResults = [];

  Future<void> _searchVideos(String query) async {
    try {
      final results = await _youtubeService.searchVideos(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print('Lỗi tìm kiếm: $e');
    }
  }

  @override
  void dispose() {
    _youtubeService.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm bài hát...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchVideos(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final video = _searchResults[index];
                return ListTile(
                  leading: Image.network(
                    video.thumbnails.mediumResUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(video.title),
                  subtitle: Text(video.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerScreen(video: video),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}