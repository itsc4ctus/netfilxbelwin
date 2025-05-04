import 'package:flutter/material.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';

Widget buildTrendingNow(AsyncSnapshot<List<Movie>> snapshot) {

  return Padding(
    padding: const EdgeInsets.all(10),
    child: ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, index) {
        final imageUrl = snapshot.data![index]?.posterPath ?? '';
        final movie = snapshot.data![index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          color: Colors.grey[900],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                movie.overview.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Image.network(
                    "$imagePath$imageUrl",
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Positioned(
                    bottom: 10,
                    right: 10,
                    child: Icon(Icons.volume_off, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: const [
                      Icon(Icons.share, color: Colors.white),
                      Text(
                        "Share",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  kWidth,
                  Column(
                    children: const [
                      Icon(Icons.add, color: Colors.white),
                      Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  kWidth,
                  Column(
                    children: const [
                      Icon(Icons.play_arrow, color: Colors.white),
                      Text(
                        "Play",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
