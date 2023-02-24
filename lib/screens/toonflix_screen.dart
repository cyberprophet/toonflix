import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/toonflix_api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class ToonflixScreen extends StatelessWidget {
  ToonflixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.green,
        title: const Text(
          'Today\'s Toons',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (_, snapshot) => snapshot.hasData
            ? Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 5,
                    child: makeList(snapshot),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) =>
      ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          var webtoon = snapshot.data![index];

          if (kDebugMode) {
            print(index);
          }
          return Webtoon(
            id: webtoon.id,
            thumb: webtoon.thumb,
            title: webtoon.title,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 20,
        ),
      );
  final Future<List<WebtoonModel>> webtoons = ToonApi.getTodaysToons();
}
