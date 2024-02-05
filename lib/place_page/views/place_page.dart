import 'package:flutter/material.dart';
import 'package:rmservice/place_page/views/place_public.dart';
import 'package:rmservice/place_page/views/place_user.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({super.key});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          flexibleSpace: Column(
            children: [
              TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                indicatorColor: colorProject.primaryColor,
                labelStyle: TextStyle(
                  color: colorProject.primaryColor,
                  fontFamily: fontBoldApp,
                  fontSize: fontSize.medium,
                ),
                tabs: [
                  Tab(
                    text: 'Bạn cần đi thuê chỗ?',
                  ),
                  Tab(
                    text: 'Tin thuê chỗ của bạn',
                  ),
                  
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PlacePublic(),
            PlaceUser()
          ],
        ),
      ),
    );
  }
}