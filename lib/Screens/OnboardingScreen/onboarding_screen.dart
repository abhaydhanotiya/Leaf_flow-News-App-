import 'package:Leaf_Flow/SharedPrefrences/sharedprefrences.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:Leaf_Flow/Constants/constant.dart';
import 'dart:ui' as ui;
import 'package:Leaf_Flow/Screens/HomeScreen/home_screen.dart';

import '../HomeScreen/home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late int currentPage;
  String apiKey = '';
  late TransformerPageController _controller;
  int indexVal = 0;
  @override
  void initState() {
    _controller = TransformerPageController(initialPage: 0);
    super.initState();

    currentPage = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundColor,
          child: TransformerPageView(
              loop: true,
              itemCount: contents.length,
              controller: IndexController(),
              itemBuilder: (context, index) {
                index = indexVal;
                return Container(
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Center(
                                child: Image.asset(
                                  contents[index].image,
                                  fit: BoxFit
                                      .contain, // Use BoxFit.contain to fit the image inside the circle
                                  height: height *
                                      0.35, // Adjust the size of the image
                                  width: height * 0.35,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: contents[index].title,
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 26,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 55),
                              child: Text(
                                contents[index].discription,
                                textAlign: index == 1
                                    ? TextAlign.start
                                    : TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.only(bottom: height * 0.025),
                          height: height * 0.15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    contents.length,
                                    (index) => buildDot(index, context),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (indexVal == 2) {
                                    Navigator.pop(context);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(
                                            index: 0,
                                          ),
                                        ));
                                  } else {
                                    setState(() {
                                      indexVal++;
                                      if (indexVal <= contents.length) {
                                        currentPage = indexVal;
                                      } else {
                                        indexVal = 0;
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  width: width * 0.9,
                                  height: width * 0.12,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      indexVal == 2 ? 'Get Started' : 'Next',
                                      style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 18,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                index: 0,
                              ),
                            ),
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textGrey,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onPageChanged: (index) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    currentPage = index as int;
                    indexVal = index;
                  });
                });
              }),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: currentPage == index ? 20 : 8,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: currentPage == index ? BoxShape.rectangle : BoxShape.circle,
        color: currentPage == index ? AppColors.blackColor : Colors.transparent,
        border: Border.all(color: AppColors.blackColor),
        borderRadius: currentPage == index ? BorderRadius.circular(6) : null,
        // color: currentIndex == index ? Colors.grey : Colors.lightGreen,
      ),
    );
  }
}

class OnbordingContent {
  String image;
  String title;
  String discription;

  OnbordingContent(
      {required this.image, required this.title, required this.discription});
}

// assets/onboarding
List<OnbordingContent> contents = [
  OnbordingContent(
      title: 'Verified News',
      image: 'assets/Images/onboarding/1.png',
      discription:
          "Our news is verified by experts and journalists and carefully selected for you"),
  OnbordingContent(
      title: 'AI made news just for you',
      image: 'assets/Images/onboarding/2.png',
      discription:
          "our Algorithm is constantly learning and improving itself to provide you with the most relevant news"),
  OnbordingContent(
      title: 'Your Feedback matters',
      image: 'assets/Images/onboarding/3.png',
      discription: "Your feedback helps us improve our news feed for you"),
];
