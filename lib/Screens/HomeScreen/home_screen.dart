import 'package:Leaf_Flow/Constants/constant.dart';
import 'package:Leaf_Flow/Screens/HomeScreen/all_articles.dart';
import 'package:Leaf_Flow/Screens/HomeScreen/top_headlines.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor1,
        body: Column(
          children: [
            SizedBox(height: height * 0.02),
            Container(
              height: 45,
              width: width * 0.9,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor1,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: AppColors.blackColor,
                ),
                labelColor: AppColors.backgroundColor,
                labelStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'All Articles',
                  ),
                  Tab(
                    text: 'Top Headlines',
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: BouncingScrollPhysics(),
                children: [
                  AllArticles(),
                  TopHeadlines(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
