
import 'package:flick_tv_ott/presentation/screen/coming_soon_page.dart';
import 'package:flick_tv_ott/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/constants/app_colors.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = '/';
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  late final ScrollController _homeScrollController;
  bool _isNavBarVisible = true;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _homeScrollController = ScrollController();
    _homeScrollController.addListener(_scrollListener);

    _pages = <Widget>[
      HomePage(),
      const ComingSoonPage(title: 'Movies'),
      const ComingSoonPage(title: 'Profile'),
    ];
  }

  @override
  void dispose() {
    _homeScrollController.removeListener(_scrollListener);
    _homeScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_homeScrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isNavBarVisible) {
        setState(() {
          _isNavBarVisible = false;
        });
      }
    }
    else if (_homeScrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isNavBarVisible) {
        setState(() {
          _isNavBarVisible = true;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvoked: (didPop) {
        if (didPop) {
          return; // If it did pop, do nothing.
        }
        if (_selectedIndex != 0) {
          _onItemTapped(0);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isNavBarVisible ? kBottomNavigationBarHeight : 0,
          child: Wrap(
            children: [
              BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie_filter),
                    label: 'Movies',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                backgroundColor: AppColors.card,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}