import 'package:f_contacter/colors.dart';
import 'package:f_contacter/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _getTabs(),
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getBottomNavigationItems(),
        onTap: _onTabClick,
        currentIndex: _page,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems() {
    return [
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/ic_contact.svg'),
          title: Text('Contacts', style: TextStyle(color: _getColor(0))),
          activeIcon: SvgPicture.asset('assets/ic_contact.svg', color: colorAccent)
      ),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/ic_status.svg'),
          title: Text('News', style: TextStyle(color: _getColor(1))),
          activeIcon: SvgPicture.asset('assets/ic_status.svg', color: colorAccent)
      ),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/ic_profile.svg'),
          title: Text('Profile', style: TextStyle(color: _getColor(2))),
          activeIcon: SvgPicture.asset('assets/ic_profile.svg', color: colorAccent)
      )
    ];
  }

  Color _getColor(int i) => i == _page ? colorAccent : colorBottomBarDefault;

  List<Widget> _getTabs() {
    return [
      ProfileScreen(),
      ProfileScreen(),
      ProfileScreen()
    ];
  }

  void _onTabClick(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}