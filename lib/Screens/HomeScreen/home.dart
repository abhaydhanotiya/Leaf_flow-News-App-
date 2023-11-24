import 'package:Leaf_Flow/Screens/HomeScreen/all_articles.dart';
import 'package:Leaf_Flow/Screens/HomeScreen/top_headlines.dart';
import 'package:flutter/material.dart';
import 'package:Leaf_Flow/Constants/constant.dart';
import 'package:Leaf_Flow/Screens/Settings/settings.dart';

class Home extends StatefulWidget {
  int? index;
  Home({required this.index});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> pages = [AllArticles(), TopHeadlines(), Settings()];
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // Use IndexedStack to keep all pages in the widget tree but only render the selected one
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // Use setState to trigger a rebuild and update the UI
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'All Articles',
            activeIcon: Icon(Icons.article, color: AppColors.primaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Top Headlines',
            activeIcon: Icon(Icons.dashboard, color: AppColors.primaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            activeIcon: Icon(Icons.settings, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
