import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflixclone/APIservice/api.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';
import 'package:netflixclone/presentation/home/mainpart.dart';
import 'package:netflixclone/presentation/widgets/main_title_card.dart';
import 'package:netflixclone/presentation/widgets/main_title_card_custom.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late Future<List<Movie>> trendingMovies;
late Future<List<Movie>> nowPlaying;
  late Future<List<Movie>> horrorPlaying;
  late Future<List<Movie>> malayalamMovies;
  late Future<List<Movie>> topTenMovies;
  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    nowPlaying = Api().getNowPlayingMovies();
    horrorPlaying = Api().getHorrorMovies();
    malayalamMovies = Api().getMalayalamMovies();
    topTenMovies = Api().getTopTenMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (context, index, child) {
          return SafeArea(
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                scrollNotifier.value = direction != ScrollDirection.reverse;
                return true;
              },
              child: Stack(
                children: [
                  ListView(
                    children: [
                      mainPart(nowPlaying: nowPlaying,),
                      SizedBox(
                        child: FutureBuilder(future: nowPlaying, builder: (context, snapshot) {
                          if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }
                          else if(snapshot.hasData){
                            final data = snapshot.data;
                            return MainTitleCard(title: "Now Playing",snapshot:snapshot ,);
                          }else{
                            return SizedBox(child: Center(child: CircularProgressIndicator(),),);
                          }
                        },),
                      ),
                      FutureBuilder<List<Movie>>(
                        future: trendingMovies,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text(snapshot.error.toString()));
                          }
                          return MainTitleCard(
                            title: "Trending Now",
                            snapshot: snapshot,
                          );
                        },
                      ),
                      SizedBox(
                        child: FutureBuilder(future: horrorPlaying, builder: (context, snapshot) {
                          if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }
                          else if(snapshot.hasData){
                            final data = snapshot.data;
                            return MainTitleCard(title: "Horror Movies",snapshot:snapshot ,);
                          }else{
                            return SizedBox(child: Center(child: CircularProgressIndicator(),),);
                          }
                        },),
                      ),
                      SizedBox(
                        child: FutureBuilder(future: topTenMovies, builder: (context, snapshot) {
                          if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }
                          else if(snapshot.hasData){
                            final data = snapshot.data;
                            return MainTitleCardCustom(title: "Top 10 Movie",snapshot:snapshot ,);
                          }else{
                            return SizedBox(child: Center(child: CircularProgressIndicator(),),);
                          }
                        },),
                      ),
                      SizedBox(
                        child: FutureBuilder(future: malayalamMovies, builder: (context, snapshot) {
                          if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }
                          else if(snapshot.hasData){
                            final data = snapshot.data;
                            return MainTitleCard(title: "Malayalam Mashup",snapshot:snapshot ,);
                          }else{
                            return SizedBox(child: Center(child: CircularProgressIndicator(),),);
                          }
                        },),
                      ),
                    ],
                  ),
                  if (scrollNotifier.value)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: Colors.black.withOpacity(0.3),
                      width: double.infinity,
                      height: 120,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                'https://pngimg.com/d/netflix_PNG10.png',
                                height: 70,
                                width: 70,
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.cast, color: Colors.white),
                                  SizedBox(width: 10),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 25,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text("TV Shows", style: TextStyle(color: Colors.white)),
                              Text("Movies", style: TextStyle(color: Colors.white)),
                              Text("Categories", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
