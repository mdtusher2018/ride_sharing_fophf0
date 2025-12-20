import 'package:flutter/material.dart';
import 'package:velozaje/feature/chat/chat_list_view.dart';
import 'package:velozaje/feature/home/home_view.dart';
import 'package:velozaje/feature/profile_and_account/profile_view.dart';
import 'package:velozaje/feature/tips_and_publications/published/process/publish_process_view.dart';
import 'package:velozaje/feature/tips_and_publications/tips_and_publication_view.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    TipsAndPublicationPage(),
    PublishProcessPage(),
    ChatListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: Container(
        height: 72,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(
              index: 0,
              selected: 'assest/nav/home_selected.png',
              unselected: 'assest/nav/home_unselected.png',
            ),

            _navItem(
              index: 1,
              selected: 'assest/nav/calendar_selected.png',
              unselected: 'assest/nav/calendar_unselected.png',
            ),

            // Center Plus Button
            GestureDetector(
              onTap: () {
                setState(() => _currentIndex = 2);
              },
              child: Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Icon(Icons.add, color: Colors.white)),
              ),
            ),

            _navItem(
              index: 3,
              selected: 'assest/nav/chat_selected.png',
              unselected: 'assest/nav/chat_unselected.png',
            ),

            _navItem(
              index: 4,
              selected: 'assest/nav/profile_selected.png',
              unselected: 'assest/nav/profile_unselected.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String selected,
    required String unselected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: Image.asset(
        _currentIndex == index ? selected : unselected,
        width: 26,
        height: 26,
      ),
    );
  }
}
