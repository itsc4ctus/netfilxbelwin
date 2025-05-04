import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/presentation/widgets/maincard.dart';
import 'package:netflixclone/presentation/widgets/maintitle.dart';

class MainTitleCardCustom extends StatelessWidget {
  final String title;
  final AsyncSnapshot snapshot;
  const MainTitleCardCustom({
    required this.title,
    required this.snapshot,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(title: title),
          kHeight,
          LimitedBox(
            maxHeight: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                snapshot.data.length,
                    (index) => Stack(
                  children: [
                    MainCard(index: index, snapshot: snapshot),
                    Positioned(
                      left: 10,
                      bottom: -10,
                      child: BorderedText(
                        strokeWidth: 5.0,
                        strokeColor: Colors.white,
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            fontSize: 100,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
