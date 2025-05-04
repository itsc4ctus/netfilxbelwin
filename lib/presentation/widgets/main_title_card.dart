import 'package:flutter/material.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/presentation/widgets/maincard.dart';
import 'package:netflixclone/presentation/widgets/maintitle.dart';

class MainTitleCard extends StatelessWidget {
  final String title;
  final AsyncSnapshot snapshot;

  const MainTitleCard({
    required this.snapshot,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!snapshot.hasData || snapshot.data.isEmpty) {
      return const Center(child: Text("No Data Available"));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => MainCard(
              snapshot: snapshot,
              index: index,
            ),
          ),
        ),
      ],
    );
  }
}
