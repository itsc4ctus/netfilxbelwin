import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflixclone/APIservice/api.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';
import 'package:netflixclone/presentation/new_and_hot/widget/comingsoon.dart';
import 'package:netflixclone/presentation/new_and_hot/widget/trendingnow.dart';

class ScreenNewHot extends StatefulWidget {
  const ScreenNewHot({super.key});

  @override
  State<ScreenNewHot> createState() => _ScreenNewHotState();
}

class _ScreenNewHotState extends State<ScreenNewHot> {
late Future<List<Movie>> trendingNow;
late Future<List<Movie>> comingSoon;
@override
  void initState() {
    trendingNow = Api().getTrendingMovies();
    comingSoon = Api().getComingSoonMovies();
  // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "New & Hot",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          actions: [
            const Icon(Icons.cast, color: Colors.white),
            const SizedBox(width: 10),
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
          ],
          bottom: TabBar(
            isScrollable: true, // Allow custom tab widths
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: const Text("🍿 Coming soon"),
                ),
              ),
              Tab(
                child: Container(
                  width: 180,
                  alignment: Alignment.center,
                  child: const Text("👀 Trending Now"),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<Movie>>(
              future: comingSoon,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return buildComingSoon(snapshot);
              },
            ),
            FutureBuilder<List<Movie>>(
              future: trendingNow,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return buildTrendingNow(snapshot);
              },
            ),
              ],
        ),
      ),
    );
  }

  Widget _buildTrendingNow(String s) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            height: 80,
            width: 80,
            color: Colors.grey[800], // Placeholder for image
          ),
          title: Text(
            "Trending Title $index",
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: const Text(
            "Brief description of trending content.",
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }
}
