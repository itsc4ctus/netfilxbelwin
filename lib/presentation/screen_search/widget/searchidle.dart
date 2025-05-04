import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/APIservice/api.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';
import 'package:netflixclone/presentation/screen_search/widget/textTitle.dart';


class SearchIdleWidget extends StatefulWidget {
  const SearchIdleWidget({super.key});

  @override
  State<SearchIdleWidget> createState() => _SearchIdleWidgetState();
}

class _SearchIdleWidgetState extends State<SearchIdleWidget> {
  late Future<List<Movie>> topSearches;

  @override
  void initState() {
    super.initState();
    topSearches = Api().getTrendingMovies();  // Fetch top trending movies on initialization
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const textTitle(title: "Top Searches"),  // Assuming TextTitle is a custom widget
          kHeight,
          FutureBuilder<List<Movie>>(
            future: topSearches,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error occurred'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Movie movie = snapshot.data![index];
                    return BeforeSearchItem(
                      imageUrl: "${imagePath}${movie.posterPath}",
                      title: movie.title.toString(),
                    );
                  },
                  separatorBuilder: (context, index) => kHeight,
                );
              } else {
                return const Center(child: Text('No top searches available'));
              }
            },
          ),
        ],
      ),
    );
  }
}
