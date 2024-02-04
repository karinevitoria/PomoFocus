import 'dart:async';
import 'package:pomo_focus/screens/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int timeLeft = 5;
  bool startCount = false;

  void _startCountDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startCount) {
        if (timeLeft == 0) {
          setState(() {
            startCount = false;
          });
        } else if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          setState(() {
            timeLeft = 0;
          });
          timer.cancel();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomNavigationBar(),
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  startCount = true;
                  _startCountDown();
                },
                color: const Color.fromARGB(255, 230, 57, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Start',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$timeLeft',
                    style: const TextStyle(
                        fontSize: 50,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'min',
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (timeLeft > 0) {
                          timeLeft -= 5;
                        }
                      });
                    },
                    color: const Color.fromARGB(255, 255, 204, 86),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      '- 5min',
                      style:
                          TextStyle(fontFamily: 'Poppins', color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        timeLeft += 5;
                      });
                    },
                    color: const Color.fromARGB(255, 29, 204, 144),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      '+ 5min',
                      style:
                          TextStyle(fontFamily: 'Poppins', color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
