import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rmservice/account_page/account_page.dart';
import 'package:rmservice/history_page/history_page.dart';
import 'package:rmservice/main_page/main_page.dart';
import 'package:rmservice/message_page/message_page.dart';
import '../../utilities/components/button_green.dart';
import '../../utilities/components/text_field.dart';
import '../../utilities/constants/app_assets.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int myCurrentIndex = 0;
  List pages = const [
    MainPage(),
    MessagePage(),
    HistoryPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: colorProject.primaryColor.withOpacity(0.15),
              blurRadius: 25,
              offset: const Offset(8, 20))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              selectedItemColor: colorProject.primaryColor,
              unselectedItemColor: Colors.black,
              currentIndex: myCurrentIndex,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: colorProject.primaryColor,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message, color: colorProject.primaryColor),
                  label: "Message",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    color: colorProject.primaryColor,
                  ),
                  label: "History",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: colorProject.primaryColor,
                  ),
                  label: "Profile",
                ),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
