import 'dart:io';

import 'package:Leaf_Flow/Api/Dio/dio_client.dart';
import 'package:Leaf_Flow/Screens/HomeScreen/all_articles.dart';
import 'package:Leaf_Flow/Screens/HomeScreen/top_headlines.dart';
import 'package:Leaf_Flow/SharedPrefrences/sharedprefrences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiValue {
  static String BASE_URL = "https://newsapi.org/v2/";

  //==========================================EveryThing APIs==================================================

  static String all_articlesURL = "everything";

  //==========================================TopHeadlines APIs==================================================

  static String top_headlinesURL = "top-headlines";

  final DioClinet _dioClinet = DioClinet.instance;

  Future<dynamic> BitcoinArticles() async {
    dynamic data = {
      'q': 'bitcoin',
      'apiKey': '718e1347c6f44a3dbe65868d5c6ca26f',
      'language': SharedPreferencesHelper.getLanguageCode(),
    };

    try {
      Response response =
          await _dioClinet.dio!.get(all_articlesURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }

  Future<dynamic> SearchAllArticles(String search) async {
    dynamic data = {
      'q': search,
      'apiKey': '718e1347c6f44a3dbe65868d5c6ca26f',
      'language': SharedPreferencesHelper.getLanguageCode(),
    };

    try {
      Response response =
          await _dioClinet.dio!.get(all_articlesURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }

  Future<dynamic> SortAllArticles(String search, sort) async {
    dynamic data = {
      'q': search,
      'sortBy': sort,
      'apiKey': '718e1347c6f44a3dbe65868d5c6ca26f',
      'language': SharedPreferencesHelper.getLanguageCode(),
    };

    try {
      Response response =
          await _dioClinet.dio!.get(all_articlesURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }

  Future<dynamic> filterAllArticles(String search, from, upto) async {
    dynamic data = {
      'q': search,
      'from': from,
      'to': upto,
      'apiKey': '718e1347c6f44a3dbe65868d5c6ca26f',
      'language': SharedPreferencesHelper.getLanguageCode(),
    };

    try {
      Response response =
          await _dioClinet.dio!.get(all_articlesURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }

  Future<dynamic> TopHeadlinesCountry() async {
    dynamic data = {
      'country': (SharedPreferencesHelper.getCountryCode()?.isEmpty ?? true)
          ? 'in'
          : SharedPreferencesHelper.getCountryCode(),
      'apiKey': '718e1347c6f44a3dbe65868d5c6ca26f',
    };

    try {
      Response response =
          await _dioClinet.dio!.get(top_headlinesURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }
}
