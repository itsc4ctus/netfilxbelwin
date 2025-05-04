import 'package:flutter/material.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    required this.index,
    required this.snapshot,
    super.key,
  });

  final int index;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final imageUrl = snapshot.data[index]?.posterPath ?? ''; // Adjust property name as per API model
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        width: 150,
        height: 200,
        child: imageUrl.isNotEmpty
            ? Image.network(
          "$imagePath$imageUrl",
          fit: BoxFit.cover,
        )
            : const Center(child: Icon(Icons.error, color: Colors.white)),
      ),
    );
  }
}
