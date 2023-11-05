import 'package:flutter/material.dart';
import 'package:rmservice/account_page/account_page.dart';
import 'package:rmservice/main_page/main_page.dart';
import 'package:rmservice/message_page/message_page.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../place_page/views/place_page.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int myCurrentIndex = 0;
  List pages = const [
    MainPage(),
    PlacePage(),
    MessagePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          title: const Text(
            'AIOHS',
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.large,
              color: colorProject.primaryColor,
            ),
          ),
          actions: const [
            Icon(
              Icons.notifications,
              color: colorProject.primaryColor,
            ),
            SizedBox(width: 20),
            Icon(
              Icons.account_circle_sharp,
              color: colorProject.primaryColor,
            ),
            SizedBox(width: 20),
          ],
        ),
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
                    icon: Icon(
                      Icons.apartment,
                      color: colorProject.primaryColor,
                    ),
                    label: "Place",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message, color: colorProject.primaryColor),
                    label: "Message",
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
      ),
    );
  }
}
