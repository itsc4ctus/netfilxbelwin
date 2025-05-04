import 'package:flutter/material.dart';
import 'package:netflixclone/APIservice/api.dart';
import 'package:netflixclone/models/movie.dart';
import 'package:netflixclone/presentation/fast_laugh/widget/video_list_item.dart';

class FastLaugh extends StatefulWidget {
  const FastLaugh({super.key});

  @override
  State<FastLaugh> createState() => _FastLaughState();
}

class _FastLaughState extends State<FastLaugh> {
  late Future<List<Movie>> fastLaugh;

  @override
  void initState() {
    super.initState();
    fastLaugh = Api().getComedyMovies(); // Get comedy movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Movie>>(
          future: fastLaugh, // Provide the future to FutureBuilder
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Show loading indicator
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Handle error
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available')); // Handle no data scenario
            }

            final List<Movie> movies = snapshot.data!;

            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return VideoListItem(movie: movies[index]); // Pass the movie to VideoListItem
              },
            );
          },
        ),
      ),
    );
  }
}
