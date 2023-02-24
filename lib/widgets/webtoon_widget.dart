import 'package:flutter/material.dart';
import 'package:toonflix/screens/toonflix_detail_screen.dart';

class Webtoon extends StatelessWidget {
  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ToonDetailScreen(
            title: title,
            thumb: thumb,
            id: id,
          ),
        ),
      ),
      child: Column(
        children: [
          Hero(
            tag: id,
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
              child: Image.network(thumb),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.fade,
            ),
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
          ),
        ],
      ),
    );
  }

  final String title, thumb, id;
}
