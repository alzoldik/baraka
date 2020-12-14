import 'package:baraka/blocs/user_bloc.dart';
import 'package:baraka/screens/categories/categories.dart';
import 'package:baraka/screens/home/home.dart';
import 'package:baraka/screens/login/login.dart';
import 'package:baraka/screens/profile/profile.dart';
import 'package:baraka/screens/registration/registration.dart';
import 'package:baraka/widgets/general.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  final int tabIndex;
  TabsScreen({this.tabIndex});
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  UserBloc userBloc;

  List<BottomNavigationBarItem> tabItems = [];
  List<Widget> _children = [
    HomeScreen(),
    CategoriesScreen(),
    LoginScreen(),
    RegistrationScreen()
  ];

  @override
  void initState() {
    if (widget.tabIndex != null) {
      setState(() => _currentIndex = widget.tabIndex);
    }
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 1));
    userBloc = Provider.of<UserBloc>(context, listen: false);
    if (userBloc.isLogin) {
      _children[2] = ProfileScreen();
      setState(() {});
    }
  }

  onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = Provider.of<UserBloc>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              items: !userBloc.isLogin
                  ? [
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            _currentIndex == 0
                                ? 'assets/imgs/home.png'
                                : 'assets/imgs/home.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          title: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: General.buildTxt(
                              txt: "الرئيسية",
                              fontSize: 12.0,
                              color:
                                  Color(General.getColorHexFromStr('#98b2c9')),
                            ),
                          )),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            _currentIndex == 1
                                ? 'assets/imgs/cats.png'
                                : 'assets/imgs/cats.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          title: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: General.buildTxt(
                              txt: "الأقسام",
                              fontSize: 12.0,
                              color:
                                  Color(General.getColorHexFromStr('#98b2c9')),
                            ),
                          )),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            _currentIndex == 2
                                ? 'assets/imgs/my-profile.png'
                                : 'assets/imgs/my-profile.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          title: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: General.buildTxt(
                              txt: "حسابي",
                              fontSize: 12.0,
                              color:
                                  Color(General.getColorHexFromStr('#98b2c9')),
                            ),
                          )),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            _currentIndex == 3
                                ? 'assets/imgs/register.png'
                                : 'assets/imgs/register.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          title: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: General.buildTxt(
                                txt: "التسجيل",
                                fontSize: 12.0,
                                color: Color(
                                    General.getColorHexFromStr('#98b2c9')),
                                isBold: true),
                          )),
                    ]
                  : [
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            _currentIndex == 0
                                ? 'assets/imgs/home.png'
                                : 'assets/imgs/home.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          title: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: General.buildTxt(
                              txt: "الرئيسية",
                              fontSize: 12.0,
                              color:
                                  Color(General.getColorHexFromStr('#98b2c9')),
                            ),
                          )),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            _currentIndex == 1
                                ? 'assets/imgs/cats.png'
                                : 'assets/imgs/cats.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          title: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: General.buildTxt(
                              txt: "الأقسام",
                              fontSize: 12.0,
                              color:
                                  Color(General.getColorHexFromStr('#98b2c9')),
                            ),
                          )),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            _currentIndex == 2
                                ? 'assets/imgs/my-profile.png'
                                : 'assets/imgs/my-profile.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          title: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: General.buildTxt(
                              txt: "حسابي",
                              fontSize: 12.0,
                              color:
                                  Color(General.getColorHexFromStr('#98b2c9')),
                            ),
                          )),
                    ])),
    );
  }
}
