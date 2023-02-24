import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  onButtonTap() async {
    await launchUrlString(
        'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => onButtonTap(),
      child: Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  episode.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
              )
            ],
          ),
        ),
      ),
    );
  }

  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });
  final String webtoonId;
  final WebtoonEpisodeModel episode;
}
