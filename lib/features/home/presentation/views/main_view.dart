import 'package:flutter/material.dart';
import 'home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const Center(
      child: Text("Search", style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text("Watchlist", style: TextStyle(color: Colors.white)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFF1A1A1A)),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              label: "WATCHLIST",
            ),
          ],
        ),
      ),
    );
  }
}
