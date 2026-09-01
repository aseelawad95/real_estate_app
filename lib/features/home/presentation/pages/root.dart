import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/favorite/presentation/pages/favorite_page.dart';
import 'package:real_estate/features/home/presentation/pages/home_page.dart';
import 'package:real_estate/features/profile/presentation/pages/profile_page.dart';
import 'package:real_estate/features/property/presentation/pages/create_post_page.dart';
import 'package:real_estate/features/search/presentation/pages/search_page.dart';


class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController controller;
  late List<Widget> screens ;
  int currentPage =0;
  @override
  void initState() {
    screens  = [
    HomePage(),
     SearchPage(),
    FavoritePage(),
    CreatePostPage(),
    ProfilePage()
  ];


    controller = PageController(initialPage: currentPage);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: screens,
        
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.textColor,
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage=index;
            });
            controller.jumpToPage(index);
          },
          
        type: BottomNavigationBarType.fixed,
          items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_alt_fill),label: 'Home',),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled),label: 'Post'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),label: 'Profile'),
        ]),
      ),
    );
    
  }
}