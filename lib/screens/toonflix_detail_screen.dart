import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/toonflix_api_service.dart';
import 'package:toonflix/widgets/episode_widget.dart';

class ToonDetailScreen extends StatefulWidget {
  const ToonDetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<ToonDetailScreen> createState() => _ToonDetailScreenState();

  final String title, thumb, id;
}

class _ToonDetailScreenState extends State<ToonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            ),
            onPressed: onHeartTap,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 25,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      margin: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 5,
                      ),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(
                              10,
                              10,
                            ),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                builder: (_, snapshot) => snapshot.hasData
                    ? Column(
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${snapshot.data!.genre}, ${snapshot.data!.age}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: LinearProgressIndicator(
                          minHeight: 1,
                          color: Colors.green,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                future: webtoon,
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                builder: (_, snapshot) => snapshot.hasData
                    ? Column(
                        children: [
                          for (var episode in snapshot.data!)
                            Episode(
                              episode: episode,
                              webtoonId: widget.id,
                            )
                        ],
                      )
                    : const Center(
                        child: LinearProgressIndicator(
                          minHeight: 1,
                          color: Colors.green,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                future: episodes,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
    webtoon = ToonApi.getToonById(widget.id);
    episodes = ToonApi.getLatestEpisodesById(widget.id);
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() => isLiked = prefs.getBool(widget.id) ?? false);
  }

  onHeartTap() async {
    setState(() => isLiked = !isLiked);
    await prefs.setBool(widget.id, isLiked);
  }

  bool isLiked = false;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late Future<WebtoonDetailModel> webtoon;
  late SharedPreferences prefs;
}
