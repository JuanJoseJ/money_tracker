import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomBar({Key? key, required this.selectedIndex, required this.onItemSelected}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemSelected,
    );
  }
}
