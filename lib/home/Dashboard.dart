import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezda_task/home/FavouriteScreen.dart';
import 'package:tezda_task/home/HomeScreen.dart';
import 'package:tezda_task/home/Profile.dart';

class BottomBarDashboard extends StatefulWidget {
  const BottomBarDashboard({super.key});

  @override
  State<BottomBarDashboard> createState() => _BottomBarDashboardState();
}

class _BottomBarDashboardState extends State<BottomBarDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    Favouritescreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(CupertinoIcons.bars),
            onPressed: () => Scaffold.of(context).openDrawer(), // Open drawer
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset(
            'assets/images/logo.jpg', // Replace with your image path
            height: 60,
            width: 90,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          height: 100, // Adjust this height as needed
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0XFFfbd404),
                ),
                child: Center(
                  child: Text(
                    'tezda',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  _onItemTapped(0); // Switch to Home tab
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorites'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  _onItemTapped(1); // Switch to Favorites tab
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  _onItemTapped(2); // Switch to Profile tab
                },
              ),
            ],
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
