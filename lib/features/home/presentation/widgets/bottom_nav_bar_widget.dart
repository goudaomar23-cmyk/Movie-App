import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.blue, width: 2)),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: "Watch List",
          ),
        ],
      ),
    );
  }
}
