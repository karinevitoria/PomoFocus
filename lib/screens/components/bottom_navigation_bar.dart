import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pomo_focus/screens/home_page.dart';
import 'package:pomo_focus/screens/calendar_page.dart';
import 'package:pomo_focus/screens/time_page.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)), // Adjust the value as needed
        color: Color.fromARGB(255, 58, 134, 255),
      ),
      child: GNav(
        tabBorderRadius: 50,
        activeColor: Colors.white,
        backgroundColor: Colors.transparent, // Set this to transparent
        tabs: [
          GButton(
            icon: Icons.home,
            iconColor: const Color.fromARGB(100, 255, 255, 255),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          GButton(
            icon: Icons.calendar_view_day_rounded,
            iconColor: const Color.fromARGB(100, 255, 255, 255),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
          ),
          GButton(
            icon: Icons.timer,
            iconColor: const Color.fromARGB(100, 255, 255, 255),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimerPage()),
              );
            },
          ),
          GButton(
            icon: Icons.person,
            iconColor: const Color.fromARGB(100, 255, 255, 255),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimerPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
