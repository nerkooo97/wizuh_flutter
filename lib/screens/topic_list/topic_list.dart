import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart'; // Uvozimo Post model
import 'package:listar_flutter_pro/repository/topic_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'topic_webview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  final TopicRepository _topicsRepository = TopicRepository();
  Future<TopicResponse>? _futureTopics;

  @override
  void initState() {
    super.initState();
    _fetchTopics();
  }

  void _fetchTopics() {
    setState(() {
      _futureTopics = _topicsRepository
          .fetch()
          .then((response) => TopicResponse.fromJson(response));
    });
  }

    void _openTopic(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          url: url,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
        Image.network(
          'https://projektnjemacka.com/wp-content/uploads/2020/06/by_Dragojuki%C4%87__2_-removebg-preview-1.png', // Put the path to your logo here
          height: 70,
        ),
        SizedBox(width: 10),
        Text("Projekt Njemačka"),
          ],
        ),
      ),
      body: FutureBuilder<TopicResponse>(
        future: _futureTopics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Greška: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(child: Text("Nema dostupnih događaja"));
          }

          final topics = snapshot.data!.data;

            return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              return GestureDetector(
              onTap: () {
                if (topic.link != null && topic.link!.isNotEmpty) {
                _openTopic(topic.link!);
                }
              },
              child: Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                  topic.featuredMediaUrl ?? '',
                  fit: BoxFit.cover,
                  ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(topic.title ?? ''),
                  ),
                ],
                ),
              ),
              );
            },
            );
        },
      ),
    );
  }
}
