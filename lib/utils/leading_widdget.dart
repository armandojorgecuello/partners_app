// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';
// import 'package:provider/provider.dart';



// class PartnerLeading extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // var singleTaskData = SingleTask.docSnapshot;
//     final taskProvider = Provider.of<TasksListProvider>(context);
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//       .collection('users')
//       .doc(taskProvider.receiverUid)
//       .collection(taskProvider.receiverUid)
//       .doc(taskProvider.receiverUid)
//       .snapshots(),
//       builder: (context, snapshot) {

//         return CircleAvatarWidget(
//           radius: 25.0,
//           imageUrl:snapshot.data() as Map<String,dynamic>['photo_url'] ??
//             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg', 
//         );
//       }
//     );
//   }
// }


// class SenderLeading extends StatelessWidget {
  
//   double radius;
//   SenderLeading({@required this.radius});


//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = Provider.of<TasksListProvider>(context);

//     // var singleTaskData = SingleTask.docSnapshot;
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//       .collection('users')
//       .doc(taskProvider.senderUid)
//       .collection(taskProvider.senderUid)
//       .doc(taskProvider.senderUid)
//       .snapshots(),
//       builder: (context, snapshot) {
//         return CircleAvatarWidget(
//           radius: radius,
//           imageUrl:snapshot.data() as Map<String,dynamic>['photo_url'] ??
//             'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg', 
//         );
//       }
//     );
//   }
// }