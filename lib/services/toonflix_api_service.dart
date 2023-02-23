import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ToonApi {
  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final res = await http.get(url);

    List<WebtoonModel> webtoonInstances = [];

    if (res.statusCode == 200) {
      for (var webtoon in jsonDecode(res.body)) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return WebtoonDetailModel.fromJson(jsonDecode(res.body));
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.parse('$baseUrl/$id/episodes');
    final res = await http.get(url);

    List<WebtoonEpisodeModel> episodesInstances = [];

    if (res.statusCode == 200) {
      for (var episode in jsonDecode(res.body)) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }

  static const String today = 'today',
      baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
}
