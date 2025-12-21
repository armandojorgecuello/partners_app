
// //Widget que maneja el Background de la tarea
// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

// class RewardImageBackground extends StatefulWidget {
//   final String rewardUrl;
//   const RewardImageBackground({
//     Key key,
//     this.rewardUrl
//   }): super(key: key);
//   @override
//   _RewardImageBackgroundState createState() => _RewardImageBackgroundState();
// }

// class _RewardImageBackgroundState extends State<RewardImageBackground> {
//   bool _isLoading = true;
//   Image imagenReward;
//   @override
//   void initState() { 
//     String image = widget.rewardUrl;
//     imagenReward = Image.network(image);
//     imagenReward.image.resolve(ImageConfiguration()).addListener(
//       ImageStreamListener((ImageInfo image, bool syncronousCall){
//         if(mounted){
//           setState(() {
//             _isLoading = false;
//           });
//         }
        
//       }));
//     super.initState();    
//   }

//     @override
//     Widget build(BuildContext context) {
//       final tween = MultiTrackTween([
//         Track("color").add(Duration(milliseconds: 800),ColorTween( begin: Colors.black, end: Colors.grey[300])),
//         Track("color1").add(Duration(milliseconds: 800), ColorTween(begin:Colors.grey[300] , end:Colors.black54))
//       ]
//       );
//       return Opacity(
//         opacity: 0.3,
//         child: _isLoading 
//           ? ControlledAnimation(
//             playback: Playback.MIRROR,
//             tween: tween,
//             duration: tween.duration,
//             builder: (context, animation){
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.topLeft,
//                     colors: [animation["color"], animation["color1"]]
//                   )
//                 ),
//               ); 
//             },
//           )
//           : SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: FadeInImage(
//               placeholder:AssetImage('assets/loading/jar-loading.gif') , 
//               image: NetworkImage(widget.rewardUrl),
//                 fit: BoxFit.cover,
//             ),
//           ),
//       );
//     }
// }
