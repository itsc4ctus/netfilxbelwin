import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: indexChangeNotifier,
      builder: (context, newIndex, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: newIndex, // Reflect the selected index
          onTap: (index) {
            indexChangeNotifier.value = index;
          },
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: "New and Hot",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.smiley_fill),
              label: "Fast Laugh",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download), // Changed icon for Downloads
              label: "Downloads",
            ),
          ],
        );
      },
    );
  }
}
