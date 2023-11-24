import 'package:Leaf_Flow/Api/api_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Constants/constant.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  String selectedSortOption = 'None';
  String selectedFilterOption = 'None';
  List searchList = [];

  // Function to show the Sort By bottom sheet
  void showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Sort By:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sortOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(sortOptions[index]['title'] ?? ''),
                      onTap: () {
                        // Handle the selection (if needed)
                        _sortmethod(sortOptions[index]['value']);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, String>> sortOptions = [
    {'title': 'Relevancy', 'value': 'relevancy'},
    {'title': 'Popularity', 'value': 'popularity'},
    {'title': 'Published At', 'value': 'publishedAt'},
  ];

  // Function to show the Filter bottom sheet
  void showFilterBottomSheet() async {
    DateTime? fromDate;
    DateTime? uptoDate;

    Future<void> pickDate(bool isFromDate) async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now(),
      );

      if (selectedDate != null) {
        setState(() {
          if (isFromDate) {
            fromDate = selectedDate;
          } else {
            uptoDate = selectedDate;
          }
        });
      }
    }

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final double height = MediaQuery.of(context).size.height;
        final double width = MediaQuery.of(context).size.width;
        return Container(
          padding: EdgeInsets.all(width * 0.05),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    'Filter By:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          pickDate(true);
                          setState(() {
                            fromDate;
                          });
                        },
                        child: Column(
                          children: [
                            Text('From Date: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                )),
                            SizedBox(height: height * 0.01),
                            Text(
                              fromDate != null
                                  ? DateFormat('yyyy-MM-dd').format(fromDate!)
                                  : 'Select date',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      InkWell(
                        onTap: () {
                          pickDate(false);
                          setState(() {
                            uptoDate;
                          });
                        },
                        child: Column(
                          children: [
                            Text('To Date: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                )),
                            SizedBox(height: height * 0.01),
                            Text(
                              uptoDate != null
                                  ? DateFormat('yyyy-MM-dd').format(uptoDate!)
                                  : 'Select date',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the filter based on fromDate and uptoDate
                    print('From Date: $fromDate');
                    print('To Date: $uptoDate');
                    _filtermethod(DateFormat('yyyy-MM-dd').format(fromDate!),
                        DateFormat('yyyy-MM-dd').format(uptoDate!));
                    Navigator.pop(context);
                  },
                  child: Text('Apply Filter'),
                ),
              ),
            ],
          ),
        );
      },
    );
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

  Future<dynamic> _searchmethod() async {
    var data = await ApiValue().SearchAllArticles(searchText);
    setState(() {
      searchList = data['articles'];
    });
  }

  Future<dynamic> _sortmethod(String? sortOption) async {
    var data = await ApiValue().SortAllArticles(searchText, sortOption);
    setState(() {
      searchList = data['articles'];
    });
  }

  Future<dynamic> _filtermethod(String? fromDate, uptoDate) async {
    var data =
        await ApiValue().filterAllArticles(searchText, fromDate, uptoDate);
    setState(() {
      searchList = data['articles'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
                width: width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.06,
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        onSubmitted: (value) {
                          _searchmethod();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          labelText: 'Search',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: AppColors.blackColor,
                            ),
                            onPressed: () {
                              // Perform search operation here
                              // You can use the searchText variable to get the search query
                              _searchmethod();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    searchList.isEmpty
                        ? Container(
                            height: height * 0.8,
                            child: Center(
                              child: Text(
                                'No Search Available',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: height * 0.8,
                            child: ListView.builder(
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: width * 0.9,
                                  margin: EdgeInsets.only(
                                      bottom: index == searchList.length - 1
                                          ? 0
                                          : height * 0.02),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.backgroundColor2,
                                      border: Border.all(
                                        color: AppColors.backgroundColor2,
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              searchList[index]['urlToImage'] ==
                                                      null
                                                  ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                                  : searchList[index]
                                                      ['urlToImage'],
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
                                              searchList[index]['title'],
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.5,
                                                  child: Text(
                                                    searchList[index]
                                                                ['author'] ==
                                                            null
                                                        ? ''
                                                        : searchList[index]
                                                            ['author'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColors.textGrey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  formattedDate(
                                                      searchList[index]
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
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              margin: EdgeInsets.only(bottom: height * 0.02),
              height: height * 0.08,
              width: width,
              color: Colors.transparent,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Adjust the radius as needed.
                              side: const BorderSide(
                                  width: 0.6,
                                  color: Colors
                                      .black), // Specify the border color.
                            ),
                          ),
                        ),
                        onPressed: () {
                          showSortBottomSheet();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Sort By',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF2B2B2B),
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    height: 1.60,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF2B2B2B),
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Adjust the radius as needed.
                              side: const BorderSide(
                                  width: 0.6,
                                  color: Colors
                                      .black), // Specify the border color.
                            ),
                          ),
                        ),
                        onPressed: () {
                          showFilterBottomSheet();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  'Filter',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xffFAF7F1),
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    height: 1.60,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Icon(
                                  Icons.filter_alt_outlined,
                                  color: const Color(0xffFAF7F1),
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
