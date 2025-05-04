import 'package:flutter/material.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';import 'package:intl/intl.dart';

Widget buildComingSoon(AsyncSnapshot<List<Movie>> snapshot) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      width: double.infinity,
      height: 450,
      color: Colors.grey[900],
      child: ListView.builder(
        itemCount: snapshot.data?.length ?? 0,
        itemBuilder: (context, index) {
          final Movie movie = snapshot.data![index+1];
          final DateTime releaseDate = DateTime.tryParse(movie.releaseDate ?? '') ?? DateTime.now();
          final String monthName = DateFormat('MMM').format(releaseDate);
          final String formattedDate = DateFormat('EEE, d MMM y').format(releaseDate);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Section
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        monthName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${releaseDate.day}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Movie Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail or Image
                      Stack(
                        children: [
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${movie.posterPath ?? ''}",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 5,
                            right: 5,
                            child: Icon(Icons.volume_off, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Movie Title and Actions
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Column(
                                children: const [
                                  Icon(Icons.alarm, color: Colors.white),
                                  Text(
                                    "Remind Me",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Column(
                                children: const [
                                  Icon(Icons.info, color: Colors.white),
                                  Text(
                                    "Info",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            movie.title ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Coming on $formattedDate",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // Movie Description
                      Text(
                        movie.overview ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
