import 'package:flutter/material.dart';
import 'package:projecttpm/loginpage.dart';
import 'package:projecttpm/view.dart';
import 'convert_money.dart';
import 'convert_time.dart';
import 'home.dart';
import 'logout.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<String> appBarTitle = [
    "Profile",
    "Valorant API",
    "Currency Converter",
    "Time Zone",
    "Logout"
  ];
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ViewPage(),
    MoneyPage(),
    TimePage(),
    LogoutPage()
  ];

  void _onItemTapped(int index) {
    if (index == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(appBarTitle[_selectedIndex] + " Page")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fireplace_rounded, color: Colors.blue),
            label: 'API',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined, color: Colors.blue),
            label: 'Convert',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse, color: Colors.blue),
            label: 'TimeZone',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    ));
  }
}
