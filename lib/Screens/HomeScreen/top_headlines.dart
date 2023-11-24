import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Api/api_value.dart';
import '../../Constants/constant.dart';
import '../../SharedPrefrences/sharedprefrences.dart';
import '../NewsScreen/news_screen.dart';
import 'Search/search.dart';
import 'home.dart';

class TopHeadlines extends StatefulWidget {
  const TopHeadlines({super.key});

  @override
  State<TopHeadlines> createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  List articles = [];

  @override
  void initState() {
    super.initState();
    TopHeadlinesMethod();
  }

  Future<dynamic> TopHeadlinesMethod() async {
    var data = await ApiValue().TopHeadlinesCountry();
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
                  value: SharedPreferencesHelper.getCountryCode(),
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
                      SharedPreferencesHelper.setCountryCode(code: newValue!);
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
                          index: 1,
                        );
                      }));
                    });
                  },
                  items: <String>[
                    'ae',
                    'ar',
                    'at',
                    'au',
                    'be',
                    'bg',
                    'br',
                    'ca',
                    'ch',
                    'cn',
                    'co',
                    'cu',
                    'cz',
                    'de',
                    'eg',
                    'fr',
                    'gb',
                    'gr',
                    'hk',
                    'hu',
                    'id',
                    'ie',
                    'il',
                    'in',
                    'it',
                    'jp',
                    'kr',
                    'lt',
                    'lv',
                    'ma',
                    'mx',
                    'my',
                    'ng',
                    'nl',
                    'no',
                    'nz',
                    'ph',
                    'pl',
                    'pt',
                    'ro',
                    'rs',
                    'ru',
                    'sa',
                    'se',
                    'sg',
                    'si',
                    'sk',
                    'th',
                    'tr',
                    'tw',
                    'ua',
                    'us',
                    've',
                    'za',
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
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: width * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Headlines',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Home(
                                index: 2,
                              );
                            }));
                          },
                          icon: Icon(
                            Icons.settings,
                            color: AppColors.blackColor,
                            size: 20,
                            weight: 5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      height: height * 0.8,
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return NewsScreen(
                                  index: index,
                                  articles: articles,
                                );
                              }));
                            },
                            child: Container(
                              width: width * 0.9,
                              margin: EdgeInsets.only(
                                  bottom: index == articles.length - 1
                                      ? 0
                                      : height * 0.02),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.backgroundColor2,
                                  border: Border.all(
                                    color: AppColors.backgroundColor2,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: height * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          articles[index]['urlToImage'] == null
                                              ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                              : articles[index]['urlToImage'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.13,
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
                                          articles[index]['title'],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: width * 0.5,
                                              child: Text(
                                                articles[index]['author'] ==
                                                        null
                                                    ? ''
                                                    : articles[index]['author'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: AppColors.textGrey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ),
                                            Text(
                                              formattedDate(articles[index]
                                                  ['publishedAt']),
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
