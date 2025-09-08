import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plate_up/Views/favorites_screen.dart';
import 'package:plate_up/Views/home_screen.dart';
import '../Utils/constants.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  late final List<Widget>pages;
  @override
  void initState() {
    pages = [
      const HomeScreen(),
      const FavoritesScreen(),
      navBarPage(Iconsax.calendar5),
      navBarPage(Icons.settings),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        backgroundColor: Colors.white,
        elevation: 40,
        iconSize: 28,
        selectedItemColor:kPrimaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 14,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: kPrimaryColor,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0?
              Iconsax.home5:Iconsax.home_1,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1?
              Iconsax.heart5:Iconsax.heart,
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2?
              Iconsax.calendar5:Iconsax.calendar_1,),
            label: "Meal Plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3?
              Icons.settings:Icons.settings_outlined,),
            label: "Settings",
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
  navBarPage(iconName){
    return Center(
        child: Icon(
          iconName,
          size: 100,
          color: kPrimaryColor,
        )
    );
  }
}
