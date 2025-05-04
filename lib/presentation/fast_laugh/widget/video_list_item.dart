import 'package:flutter/material.dart';
import 'package:netflixclone/domain/core/constants/constants.dart';
import 'package:netflixclone/models/movie.dart';

class VideoListItem extends StatelessWidget {
 final Movie movie;
  const VideoListItem({required this.movie,super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.network("${imagePath}${movie.posterPath}",fit: BoxFit.fill,),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(

                      backgroundImage: null,
                      backgroundColor: Colors.black.withOpacity(0.6), radius: 40,child: IconButton(onPressed: (){}, icon: Icon(Icons.volume_off,size: 50,color: Colors.white,))),

                ),
                kHeight,
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  CircleAvatar(),
                  VideoActionsWidget(icon: Icons.emoji_emotions_rounded, data: "LOL"),
                    VideoActionsWidget(icon: Icons.add, data: "My List"),
                    VideoActionsWidget(icon: Icons.share, data: "Share"),
                    VideoActionsWidget(icon: Icons.play_arrow, data: "Play"),

                ],),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class VideoActionsWidget extends StatelessWidget {
  VideoActionsWidget({required this.icon,required this.data,super.key});
  final IconData? icon;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Icon(icon,color: Colors.white,shadows: [Shadow(color: Colors.black,blurRadius: 1)],),
          Text(data,style: TextStyle(
            letterSpacing: 1,
            color: Colors.white,
          ),),
        ],
      ),
    );
  }
}
