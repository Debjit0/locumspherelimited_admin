
import 'package:flutter/material.dart';
import 'package:locumspherelimited_admin/Employee%20Screen/employee_screen.dart';
import 'package:locumspherelimited_admin/Unit%20Screen/unit_screen.dart';
import 'package:locumspherelimited_admin/Home%20Screen/home.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const [
          HomeScreen(),
          EmployeesScreen(),
          UnitsScreen(),
        ][selectedPageIndex],
        bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Influencers',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.group),
              icon: Icon(Icons.group_outlined),
              label: 'Employees',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.work),
              icon: Icon(Icons.work_outline),
              label: 'Units',
            ),
          ],
        ),
      
    );
  }
}