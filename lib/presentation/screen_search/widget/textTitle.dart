import 'package:flutter/material.dart';
class textTitle extends StatelessWidget {
  final String title;
  const textTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class BeforeSearchItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const BeforeSearchItem({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 100,
          width: 160,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const Icon(
          Icons.play_circle_outline,
          color: Colors.white,
          size: 50,
        ),
      ],
    );
  }
}