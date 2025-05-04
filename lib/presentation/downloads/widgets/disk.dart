import 'dart:math';
import 'package:flutter/material.dart';
import 'package:netflixclone/APIservice/api.dart';
import 'package:netflixclone/domain/core/colors/colors.dart';
import 'package:netflixclone/models/movie.dart';

class Disk extends StatefulWidget {
  const Disk({super.key});

  @override
  State<Disk> createState() => _DiskState();
}

class _DiskState extends State<Disk> {
  late Future<List<Movie>> diskImages;

  @override
  void initState() {
    super.initState();
    diskImages = Api().getMalayalamMovies();  // Fetch Malayalam movies
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      color: backgroundColor,
      width: size.width,
      height: size.height * 0.5, // Adjust height to fit the design
      child: FutureBuilder<List<Movie>>(
        future: diskImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching movies'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Movie> movies = snapshot.data!;

            // Get first three movies from the fetched list
            List<String> imageUrls = [
              'https://image.tmdb.org/t/p/w500${movies[0].posterPath}',
              'https://image.tmdb.org/t/p/w500${movies[1].posterPath}',
              'https://image.tmdb.org/t/p/w500${movies[2].posterPath}',
            ];

            return Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle
                CircleAvatar(
                  radius: size.width * 0.35,
                  backgroundColor: Colors.grey.withOpacity(0.6), // Add color for better visibility
                ),
                // Left Image
                Transform.translate(
                  offset: Offset(-90, 0),
                  child: Transform.rotate(
                    angle: -15 * pi / 180, // Slight left tilt
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(imageUrls[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: size.width * 0.3,
                      height: size.width * 0.45,
                    ),
                  ),
                ),
                // Right Image
                Transform.translate(
                  offset: Offset(90, 0),
                  child: Transform.rotate(
                    angle: 15 * pi / 180, // Slight right tilt
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(imageUrls[1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: size.width * 0.3,
                      height: size.width * 0.45,
                    ),
                  ),
                ),
                // Center Image
                Transform.translate(
                  offset: Offset(0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageUrls[2]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: size.width * 0.35,
                    height: size.width * 0.5,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No movies available'));
          }
        },
      ),
    );
  }
}
