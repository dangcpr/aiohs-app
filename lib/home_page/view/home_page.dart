import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/account/account.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_cubit.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_state.dart';
import 'package:rmservice/history/views/overview/history.dart';
import 'package:rmservice/main_page/main_page.dart';
import 'package:rmservice/message_page/message_page.dart';
import 'package:rmservice/place_page/views/place_page.dart';
import 'package:rmservice/profile/profile.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int myCurrentIndex = 0;
  List pages = const [
    MainPage(),
    HistoryPage(),
    PlacePage(),
    MessagePage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetProductCubit>(context).getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetProductCubit, GetProductState>(
      listener: (context, state) {
        debugPrint(state.toString());
        if (state is GetProductLoading) {
          print("state loading");
          WidgetsBinding.instance.addPostFrameCallback((_) => SnackBar(
                content: Text("ABC"),
                duration: const Duration(seconds: 1),
              ));
          BlocProvider.of<GetProductCubit>(context).reset();
        }
        if (state is GetProductLoaded) {
          //Navigator.pop(context);
          //debugPrint(state.products);
        }
        if (state is GetProductError) {
          showDialog(
            context: context,
            builder: (context) {
              return DialogWrong(
                notification: state.message,
              );
            },
          );
        } else {
          return;
        }
      },
      child: SafeArea(
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
            actions: [
              const Icon(
                Icons.notifications,
                color: colorProject.primaryColor,
              ),
              const SizedBox(width: 20),
            ],
          ),
          bottomNavigationBar: Container(
            height: 70,
            //margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colorProject.primaryColor.withOpacity(0.3),
                  blurRadius: 25,
                  //offset: const Offset(8, 20)
                )
              ],
            ),
            child: ClipRRect(
              //borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: BottomNavigationBar(
                selectedItemColor: colorProject.primaryColor,
                //selectedIconTheme: IconThemeData(color: colorProject.primaryColor.withOpacity(0.3)),
                selectedLabelStyle: TextStyle(fontFamily: fontBoldApp),
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
                      Icons.history,
                      color: colorProject.primaryColor,
                    ),
                    label: "History",
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
                ],
              ),
            ),
          ),
          body: BlocBuilder<GetProductCubit, GetProductState>(
              builder: (context, state) {
            if (state is GetProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: colorProject.primaryColor,
                ),
              );
            }

            if (state is GetProductLoaded) {
              return pages[myCurrentIndex];
            }

            if (state is GetProductError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: colorProject.primaryColor,
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
