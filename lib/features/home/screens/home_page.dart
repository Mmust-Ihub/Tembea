import 'package:flutter/material.dart';
import 'package:tembea/features/Auth/pages/profile_screen.dart';
import 'package:tembea/features/wishlist/screens/wishlist_screen.dart';
import 'package:tembea/features/home/screens/explore_screen.dart';
import 'package:tembea/features/home/screens/home_screen.dart';
import 'package:tembea/features/home/screens/my_location_screen.dart';
// import 'package:tembea/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedScreen = 0;
  void changeScreen(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  final List _pages = [
    HomeScreen(),
    const ExploreScreen(),
    const MyLocationScreen(),
    const WishlistScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedScreen],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedScreen,
            onTap: (value) {
              changeScreen(value);
            },
            elevation: 0,
            selectedItemColor: Colors.grey.shade900,
            selectedIconTheme: IconThemeData(color: Colors.grey.shade900),
            unselectedIconTheme: IconThemeData(color: Colors.grey.shade500),
            unselectedItemColor: Colors.grey.shade400,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  // color: Colors.grey.shade300,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_pin),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: "Favourite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: "Profile",
              ),
            ]),
      ),
    );
  }
}
