import "package:flutter/material.dart";
import 'package:pomo_focus/screens/home_page.dart';
import 'package:pomo_focus/screens/calendar_page.dart';
import 'package:pomo_focus/screens/time_page.dart';

class RedirectPage extends StatefulWidget {
  RedirectPage({super.key});

  @override
  _RedirectPage createState() => _RedirectPage();
}

class _RedirectPage extends State<RedirectPage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setCurrentPage(page) {
    setState(() {
      paginaAtual = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: setCurrentPage,
          children: [
            const HomePage(),
            CalendarPage(),
            TimerPage(),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: const Color.fromARGB(110, 255, 255, 255),
            currentIndex: paginaAtual,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 58, 134, 255),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_view_week_rounded), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.timer), label: ''),
            ],
            onTap: (page) {
              pc.animateToPage(page,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease);
            },
          ),
        ));
  }
}
