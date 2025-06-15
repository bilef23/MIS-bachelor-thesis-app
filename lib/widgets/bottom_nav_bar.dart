import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Color navBarColor;
  final bool isLoggedIn;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.navBarColor,
    required this.onTap,
    required this.isLoggedIn,
  }) : super(key: key);

  List<BottomNavigationBarItem> getNavItems() {
    if (isLoggedIn) {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Почетна',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Дипломска',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: 'Процедура за дипломска',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Листа на дипломски',
        ),
      ];
    } else {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Почетна',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Листа на дипломски',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: navBarColor,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: onTap,
      items: getNavItems(),
      type: BottomNavigationBarType.fixed,
    );
  }
}
