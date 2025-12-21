// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:honey_iou_updated/src/providers/usuarios_provider.dart';

// class PartnerListItemTask extends StatefulWidget {
//   final String? userUid;
//   final List<DocumentSnapshot>? partners;

//   const PartnerListItemTask({super.key, this.userUid, this.partners});

//   @override
//   _PartnerListItemTaskState createState() =>
//       _PartnerListItemTaskState(userUid, partners);
// }

// class _PartnerListItemTaskState extends State<PartnerListItemTask> {
//   final String? userUid;
//   final List<DocumentSnapshot>? partners;

//   _PartnerListItemTaskState(this.userUid, this.partners);

//   @override
//   Widget build(BuildContext context) {
//     // AppLocalizations? localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 15.0),
//           StreamBuilder(
//             stream: UsuarioProvider().getPartnerDataList(partners!),
//             builder: (context, snapshotUser) {
//               if (snapshotUser.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else {
//                 return SizedBox();
//                 // StaggeredGridView.countBuilder(
//                 //   shrinkWrap: true,
//                 //   crossAxisCount: 8,
//                 //   itemCount: snapshotUser.data.length,
//                 //   staggeredTileBuilder: (int index) {
//                 //     if (snapshotUser.data() as Map<String,dynamic>[index]["name"].length > 5 && snapshotUser.data() as Map<String,dynamic>[index]["name"].length < 10 ) {
//                 //         return StaggeredTile.count(3, 1);
//                 //       } else if (snapshotUser.data() as Map<String,dynamic>[index]["name"].length > 10 && snapshotUser.data() as Map<String,dynamic>[index]["name"].length < 15) {
//                 //         return StaggeredTile.count(3, 1);
//                 //       } else if (snapshotUser.data() as Map<String,dynamic>[index]["name"].length > 15) {
//                 //         return StaggeredTile.count(4, 1);
//                 //       } else {
//                 //         return StaggeredTile.count(4, 1);
//                 //       }
//                 //     },

//                 //   itemBuilder: (BuildContext context, int index) {
//                 //     return GestureDetector(
//                 //       onTap: (){
//                 //         Provider.of<TasksListProvider>(context,listen:false).secondFilter = snapshotUser.data() as Map<String,dynamic>[index];
//                 //       },
//                 //       child: Container(
//                 //         width: MediaQuery.of(context).size.width*0.25,
//                 //         decoration:BoxDecoration(
//                 //           color:Color(0xff282828),
//                 //           borderRadius: BorderRadius.circular(50.0)
//                 //         ),
//                 //         padding: EdgeInsets.only(left:3.0, right: 3.0 ),
//                 //         child:Center(
//                 //           child: Row(
//                 //             mainAxisAlignment: MainAxisAlignment.center,
//                 //             children: [
//                 //               snapshotUser.data() as Map<String,dynamic>[index]["photo_url"] != null ?
//                 //               CircleAvatarWidget(
//                 //                 radius: 15.0,
//                 //                 imageUrl: '${snapshotUser.data() as Map<String,dynamic>[index]["photo_url"]}',
//                 //               ) : CircleAvatar(
//                 //                 backgroundImage:AssetImage("assets/image/no_image.png"),
//                 //                 radius: 15.0,
//                 //               ),
//                 //               SizedBox(width: 5.0,),
//                 //               SizedBox(
//                 //                 width: MediaQuery.of(context).size.width*0.21,
//                 //                 child: Text('${snapshotUser.data() as Map<String,dynamic>[index]["name"]}', style: TextStyle(color:Colors.white, fontFamily: "Sans", fontSize: 15.0), overflow: TextOverflow.ellipsis,)
//                 //               ),
//                 //             ],
//                 //           )
//                 //         ),
//                 //       ),
//                 //     );
//                 //   },
//                 //   mainAxisSpacing: 4.0,
//                 //   crossAxisSpacing: 4.0,
//                 // );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
