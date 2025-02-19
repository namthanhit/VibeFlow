import 'package:flutter/material.dart';
import 'package:vibe_flow/ui/home/home_tab.dart';
import 'package:vibe_flow/ui/search/search.dart';
import 'package:vibe_flow/ui/library/library.dart';
import 'package:vibe_flow/ui/history/history.dart';
import 'package:vibe_flow/ui/setting/settings.dart';

class MusicHomePage extends StatefulWidget {
  final Function()? onSignOut;

  const MusicHomePage({super.key, this.onSignOut});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  int _currentTabIndex = 0;
  final List<Widget> _tabs = [
    const HomeTab(),
    const SearchTab(),
    const LibraryTab(),
    const HistoryTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VibeFlow'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: widget.onSignOut,
          ),
        ],
      ),
      body: _tabs[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onTabChanged,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tìm kiếm'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Thư viện'),
        ],
      ),
    );
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }
}