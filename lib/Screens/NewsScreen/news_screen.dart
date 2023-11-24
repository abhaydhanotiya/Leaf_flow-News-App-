import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  final int index;
  final List articles;

  NewsScreen({
    required this.index,
    required this.articles,
  });

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.articles[widget.index]['urlToImage'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                Text(
                  widget.articles[widget.index]['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.articles[widget.index]['description'],
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Source: ${widget.articles[widget.index]['source']['name']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Author: ${widget.articles[widget.index]['author']}'),
                Text(
                  'Published: ${widget.articles[widget.index]['publishedAt']}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
