import 'package:flutter/material.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';
class mainPart extends StatelessWidget {
  final Future<List<Movie>> nowPlaying;

  const mainPart({
    required this.nowPlaying,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: nowPlaying,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 600,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            height: 600,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final movie = snapshot.data![0]; // Get the first movie
          return Stack(
            children: [
              // Display the movie poster
              Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("$imagePath${movie.backDropPath.toString()}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Add your buttons or other content
              homebuttons(),
            ],
          );
        }
        return const SizedBox(
          height: 600,
          child: Center(child: Text('No movies available')),
        );
      },
    );
  }
}
class homebuttons extends StatelessWidget {
  const homebuttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            mainPartButton(icon: Icons.add,title: "My List",),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              ),
              onPressed: (){}, icon: Icon(Icons.play_arrow),label: Text("Play",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,),),),
            mainPartButton(icon: Icons.info_outline,title: "Info",),



          ],
        ),
      ),
    );
  }
}

class mainPartButton extends StatelessWidget {
  final IconData? icon;
  final String title;
  const mainPartButton({
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,color: Colors.white,size: 30,),
        Text(title)
      ],
    );
  }
}