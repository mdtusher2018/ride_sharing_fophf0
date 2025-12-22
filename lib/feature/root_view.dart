import 'package:flutter/material.dart';
import 'package:velozaje/feature/chat/chat_list_view.dart';
import 'package:velozaje/feature/home/home_view.dart';
import 'package:velozaje/feature/profile_and_account/profile_view.dart';
import 'package:velozaje/feature/tips_and_publications/published/process/publish_process_view.dart';
import 'package:velozaje/feature/tips_and_publications/tips_and_publication_view.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  static int currentIndex = 0;
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<Widget> _pages = [
    HomePage(),
    TipsAndPublicationPage(),

    ChatListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[RootPage.currentIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 12, spreadRadius: 2),
          ],
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
            SizedBox(),
            _navItem(
              index: 2,
              selected: 'assest/nav/chat_selected.png',
              unselected: 'assest/nav/chat_unselected.png',
            ),
            _navItem(
              index: 3,
              selected: 'assest/nav/profile_selected.png',
              unselected: 'assest/nav/profile_unselected.png',
            ),
          ],
        ),
      ),

      // Floating Action Button (FAB)
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PublishProcessPage();
              },
            ),
          );
        },
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: Icon(Icons.add, color: Colors.white, size: 32)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _navItem({
    required int index,
    required String selected,
    required String unselected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() => RootPage.currentIndex = index);
      },
      child: Image.asset(
        RootPage.currentIndex == index ? selected : unselected,
        width: 30, // Slightly larger icons
        height: 30, // Slightly larger icons
      ),
    );
  }
}
