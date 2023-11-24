import 'package:Leaf_Flow/Constants/constant.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: SizedBox(),
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: height * 0.8,
          width: width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.2,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'About Us',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blackColor,
                            size: width * 0.04,
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.blackColor,
                        thickness: 0.8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blackColor,
                            size: width * 0.04,
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.blackColor,
                        thickness: 0.8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blackColor,
                            size: width * 0.04,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
