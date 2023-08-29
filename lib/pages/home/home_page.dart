import 'package:chow/pages/account/account_page.dart';
import 'package:chow/pages/cart/cart_history.dart';
import 'package:chow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'main_food_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;


  List pages = [
    const MainFoodPage(),
    Container(child: const Center(child: Text("Next Page")),),
    const CartHistory(),
    const AccountPage(),

  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      Container(child: const Center(child: Text("Next Page")),),
      const CartHistory(),
      // Container(child: const Center(child: Text("Next next Page")),),
      const AccountPage(),
      // Container(child: const Center(child: Text("Next next next Page")),),

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_filled),
        title: "Home",
        activeColorPrimary: AppColors.cBgColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.archive_rounded),
        title: "History",
        activeColorPrimary: AppColors.cBgColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: "Cart",
        activeColorPrimary: AppColors.cBgColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: AppColors.cBgColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
    ];
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],

      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}
