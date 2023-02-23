import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/toonflix_api_service.dart';

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
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
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
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(5, 15),
                                      blurRadius: 15,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      episode.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
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
    webtoon = ToonApi.getToonById(widget.id);
    episodes = ToonApi.getLatestEpisodesById(widget.id);
  }

  late Future<List<WebtoonEpisodeModel>> episodes;
  late Future<WebtoonDetailModel> webtoon;
}
