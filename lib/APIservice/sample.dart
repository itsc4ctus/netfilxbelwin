// import 'package:flutter/material.dart';
// import 'package:netflixclone/domain/core/constants/constants.dart';
// class mainCard extends StatelessWidget {
//   const mainCard({
//     required this.index,
//     required this.snapShot,
//     super.key,
//   });
//   final int index;
//   final AsyncSnapshot snapShot;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.red,
//
//         ),
//         width: 150,
//         height: 200,
//         child: Image.network(
//           "${imagePath}${snapShot[index].}",
//           fit: BoxFit.cover,),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:netflixclone/domain/core/constants/constants.dart';
// import 'package:netflixclone/presentation/widgets/maincard.dart';
// import 'package:netflixclone/presentation/widgets/maintitle.dart';
//
//
// class mainTitleCard extends StatelessWidget {
//   final String title;
//   const mainTitleCard({
//     required this.snapshot,
//     required this.title,
//     super.key,
//   });
//
//   final AsyncSnapshot snapshot;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         MainTitle(title: "$title"),
//         kHeight,
//         LimitedBox(
//           maxHeight: 200,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: List.generate(10, (index) => mainCard(snapShot:snapshot,index: index,),),
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:netflixclone/APIservice/api.dart';
// import 'package:netflixclone/domain/core/constants/constants.dart';
// import 'package:netflixclone/models/movie.dart';
// import 'package:netflixclone/presentation/home/mainpart.dart';
// import 'package:netflixclone/presentation/widgets/main_title_card.dart';
// import 'package:netflixclone/presentation/widgets/main_title_card_custom.dart';
// import 'package:netflixclone/presentation/widgets/maincard.dart';
// import 'package:netflixclone/presentation/widgets/maintitle.dart';
//
// ValueNotifier<bool> scrillNotifier = ValueNotifier(true);
// class ScreenHome extends StatefulWidget {
//   const ScreenHome({super.key});
//
//   @override
//   State<ScreenHome> createState() => _ScreenHomeState();
// }
//
//
//
// class _ScreenHomeState extends State<ScreenHome> {
//   late Future<List<Movie>> trendingMovies;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     trendingMovies = Api().getTrendingMovies();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:ValueListenableBuilder(
//           valueListenable: scrillNotifier,
//           builder: (context,index,child) {
//             return SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: NotificationListener<UserScrollNotification>(
//                   onNotification: (notification){
//                     final ScrollDirection direction = notification.direction;
//                     print(direction);
//                     if(direction == ScrollDirection.reverse){
//                       scrillNotifier.value = false;
//                     }else if(direction == ScrollDirection.forward){
//                       scrillNotifier.value = true;
//                     }
//                     return true;
//                   },
//                   child: Stack(
//                     children: [
//                       ListView(
//                         children: [
//                           mainPart(),
//
//                           // mainTitleCard(title: "Released in the past year",),
//                           SizedBox(
//                             child: FutureBuilder(future: trendingMovies, builder: (context, snapshot) {
//                               if(snapshot.hasError){
//                                 return Center(child: Text(snapshot.error.toString()),);
//                               }
//                               else if(snapshot.hasData){
//                                 final data = snapshot.data;
//                                 return mainTitleCard(title: "Trending Now",snapshot:snapshot ,);
//                               }else{
//                                 return SizedBox(child: Center(child: CircularProgressIndicator(),),);
//                               }
//                             },),
//                           ),
//                           //
//                           // mainTitleCard(title: "Tense Dramas",),
//                           mainTitleCardCustom(title: "Top 10 TV shows in India today",),
//
//                           // mainTitleCard(title: "South Indian Cinema",),
//                         ],
//                       ),
//                       scrillNotifier.value == true? AnimatedContainer(
//                         duration:Duration(microseconds: 1000) ,
//                         child: Column(
//
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Image.network('https://pngimg.com/d/netflix_PNG10.png',height: 70,width: 70,),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.cast,color: Colors.white,),
//                                       SizedBox(width: 10,),
//                                       Container(
//                                         height: 50,
//                                         width: 50,
//                                         color: Colors.red,
//                                       ),
//                                       kWidth,
//                                     ],
//                                   ),
//                                 ),
//                               ],),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text("TV Shows"),
//                                 Text("Movies"),
//                                 Text("Categories")
//                               ],
//                             ),
//                           ],
//                         ),
//                         width: double.infinity,
//                         height:100,
//                         color: Colors.black.withOpacity(0.3),
//                       ):kHeight,
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//       ),
//     );
//   }
// }