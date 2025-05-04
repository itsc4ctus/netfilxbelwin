import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/APIservice/api.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';
import 'package:netflixclone/presentation/screen_search/widget/searchidle.dart';
import 'package:netflixclone/presentation/screen_search/widget/serach_result.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Movie>> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = Future.value([]); // Initial state, no results
  }

  // Perform the search and update the searchResults variable
  void _searchMovies(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchResults = Api().searchMovies(query); // Call the API to fetch search results
      });
    } else {
      setState(() {
        searchResults = Future.value([]); // If no query, reset to empty list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search field to input search queries
              CupertinoSearchTextField(
                controller: _controller,
                onChanged: _searchMovies, // Trigger search on text change
                backgroundColor: Colors.grey.withOpacity(0.4),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.grey,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              kHeight,
              // Display search results using FutureBuilder
              Expanded(
                child: FutureBuilder<List<Movie>>(
                  future: searchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator()); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error occurred')); // Handle errors
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return SearchResult(movies: snapshot.data!); // Show search results
                    } else {
                      return const SearchIdleWidget(); // Show idle state when no results
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
