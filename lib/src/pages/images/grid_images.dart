// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// class ImageGridItem extends StatefulWidget {
//   const ImageGridItem({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _ImageGridItemState createState() => _ImageGridItemState();
// }

// class _ImageGridItemState extends State<ImageGridItem> {
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(
//       context,
//       AppLocalizations,
//     );
//     final pref = UserPreferences();
//     String user = pref.uid;
//     return StreamBuilder<QuerySnapshot>(
//       stream:
//           FirebaseFirestore.instance
//               .collection('user_gallery_images')
//               .doc(user)
//               .collection(user)
//               .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error in receiving trip photos: ${snapshot.error}');
//         }
//         switch (snapshot.connectionState) {
//           case ConnectionState.none:
//             return Text('Not connected to the Stream or null');
//           case ConnectionState.waiting:
//             return Text('Awaiting for interaction');
//           case ConnectionState.active:
//             print("Stream has started but not finished");
//             var totalPhotosCount = 0;
//             List<DocumentSnapshot> tripPhotos;
//             if (snapshot.hasData) {
//               tripPhotos = snapshot.data.docs;
//               totalPhotosCount = tripPhotos.length;
//               if (totalPhotosCount > 0) {
//                 return GridView.builder(
//                   itemCount: totalPhotosCount,
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   primary: false,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                   ),
//                   itemBuilder: (BuildContext context, int index) {
//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                         child: SizedBox(
//                           height: 250,
//                           width: MediaQuery.of(context).size.width * 1 / 0.25,
//                           child: Container(
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(height: 10.0),
//                                 ClipRRect(
//                                   child: Align(
//                                     alignment: Alignment.topCenter,
//                                     heightFactor: 0.6,
//                                     child: SizedBox(
//                                       height: 183.0,
//                                       width:
//                                           MediaQuery.of(context).size.width *
//                                           1 /
//                                           0.25,
//                                       child: CachedNetworkImage(
//                                         placeholder:
//                                             (context, url) => Center(
//                                               child:
//                                                   CircularProgressIndicator(),
//                                             ),
//                                         imageUrl:
//                                             '${tripPhotos[index].data() as Map<String,dynamic>['photo_url']}' ??
//                                             '',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width * 0.5,
//                   ),
//                 ),
//                 Text(
//                   localizations.t('images.text_1'),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             );
//           case ConnectionState.done:
//             return Text('Streaming is done');
//         }
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.5,
//               ),
//             ),
//             Text(
//               localizations.t('images.text_1'),
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
