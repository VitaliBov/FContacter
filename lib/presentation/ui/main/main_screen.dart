import 'package:f_contacter/presentation/ui/contacts/contacts_screen.dart';
import 'package:f_contacter/presentation/ui/profile/profile_screen.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

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
        elevation: 0.0
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

  List<BottomNavigationBarItem> _getBottomNavigationItems() => [
    BottomNavigationBarItem(
        icon: SvgPicture.asset(AppImages.mainMenuItemContact),
        title: Text('Contacts', style: TextStyle(color: _getColor(0))),
        activeIcon: SvgPicture.asset(AppImages.mainMenuItemContact, color: AppColors.colorAccent)),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(AppImages.mainMenuItemStatus),
        title: Text('News', style: TextStyle(color: _getColor(1))),
        activeIcon: SvgPicture.asset(AppImages.mainMenuItemStatus, color: AppColors.colorAccent)),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(AppImages.mainMenuItemProfile),
        title: Text('Profile', style: TextStyle(color: _getColor(2))),
        activeIcon: SvgPicture.asset(AppImages.mainMenuItemProfile, color: AppColors.colorAccent))
  ];

  Color _getColor(int i) => i == _page ? AppColors.colorAccent : AppColors.colorBottomBarDefault;
  List<Widget> _getTabs() => [ContactsScreen(), ProfileScreen(), ProfileScreen()];

  void _onTabClick(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }
}