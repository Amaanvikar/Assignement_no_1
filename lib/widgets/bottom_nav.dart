import 'package:assignment/listing/screens/fetch_data_screen.dart';
import 'package:assignment/listing/screens/map_screen.dart';
import 'package:assignment/pagination/screens/pagination_screen.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    fetchData(),
    PaginationScreen(),
    MapScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(3, (index) {
          return BottomNavigationBarItem(
              icon: Stack(
            alignment: Alignment.topCenter,
          ));
        }),
      ),
    );
  }
}
