import 'dart:developer';

import 'package:Leaf_Flow/Screens/HomeScreen/Search/search.dart';
import 'package:Leaf_Flow/SharedPrefrences/sharedprefrences.dart';
import 'package:intl/intl.dart';
import 'package:Leaf_Flow/Constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Api/api_value.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'home.dart';

class AllArticles extends StatefulWidget {
  const AllArticles({super.key});

  @override
  State<AllArticles> createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles> {
  List articles = [];

  @override
  void initState() {
    super.initState();
    BitcoinArticles();
  }

  Future<dynamic> BitcoinArticles() async {
    var data = await ApiValue().BitcoinArticles();
    print(data);
    setState(() {
      if (data['status'] == 'ok') {
        articles = data['articles'];
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.backgroundColor,
            textColor: AppColors.blackColor,
            fontSize: 16.0);
      }
    });
  }

  String formattedDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor1,
          appBar: AppBar(
            //create a dropdown for selecting the language
            backgroundColor: AppColors.backgroundColor,
            leading: Image.asset(
              'assets/Images/logo.png',
              height: height * 0.05,
              width: width * 0.05,
            ),
            title: Text(
              'Leaf Flow',
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreen();
                  }));
                },
                icon: Icon(
                  Icons.search,
                  color: AppColors.blackColor,
                  size: 20,
                  weight: 5,
                ),
              ),
              //dropdown with country code only
              Padding(
                padding: EdgeInsets.only(right: width * 0.02),
                child: DropdownButton<String>(
                  menuMaxHeight: height * 0.3,
                  value: SharedPreferencesHelper.getLanguageCode(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.blackColor,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontFamily: 'Roboto',
                  ),
                  underline: Container(
                    height: 2,
                    color: AppColors.blackColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      SharedPreferencesHelper.setLanguageCode(code: newValue!);
                      //fluttertoast message
                      Fluttertoast.showToast(
                        msg: "Language Saved Successfully.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.backgroundColor,
                        textColor: AppColors.blackColor,
                        fontSize: 16.0,
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Home(
                          index: 0,
                        );
                      }));
                    });
                  },
                  items: <String>[
                    'ar',
                    'de',
                    'en',
                    'es',
                    'fr',
                    'he',
                    'it',
                    'nl',
                    'no',
                    'pt',
                    'ru',
                    'sv',
                    'ud',
                    'zh'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                // tranding news container
                Container(
                  height: height * 0.05,
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'News About Leaf Flow',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.38,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.backgroundColor1,
                    border: Border.all(
                      color: AppColors.backgroundColor2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('assets/Images/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.127,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: AppColors.backgroundColor,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Leaf Flow App Emerges as Trendsetter, Revolutionizing News Consumption.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Leaf Flow',
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  '2h ago',
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.05,
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending News About Bitcoin',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.15,
                  width: width * 0.9,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) => Container(
                      width: width * 0.7,
                      margin: index == articles.length - 1
                          ? EdgeInsets.zero
                          : EdgeInsets.only(right: width * 0.05),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.backgroundColor2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: height * 0.15,
                            width: width * 0.43,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  articles[index]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  articles[index]['description'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.15,
                                      height: height * 0.02,
                                      child: Text(
                                        articles[index]['source']['name'],
                                        style: TextStyle(
                                          color: AppColors.textGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      formattedDate(
                                          articles[index]['publishedAt']),
                                      style: TextStyle(
                                        color: AppColors.textGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.15,
                            width: width * 0.264,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.backgroundColor2,
                              image: DecorationImage(
                                image: NetworkImage(articles[index]
                                            ['urlToImage'] ==
                                        null
                                    ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                    : articles[index]['urlToImage']),
                                fit: BoxFit.cover,
                              ),
                            ),

                            // child: CachedNetworkImage(
                            //   imageUrl: articles[index]['urlToImage'] == null
                            //       ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                            //       : articles[index]['urlToImage'],
                            //   imageBuilder: (context, imageProvider) => Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(20),
                            //       image: DecorationImage(
                            //         image: imageProvider,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            //   placeholder: (context, url) => Shimmer.fromColors(
                            //     baseColor: AppColors.backgroundColor1,
                            //     highlightColor: AppColors.backgroundColor2,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(20),
                            //         color: AppColors.backgroundColor,
                            //       ),
                            //     ),
                            //   ),
                            //   errorWidget: (context, url, error) =>
                            //       Icon(Icons.error),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
