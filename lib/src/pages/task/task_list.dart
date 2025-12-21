// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:honeyiou/src/widget/circle_avatar_widget.dart';

// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import 'package:honeyiou/src/models/user_model.dart';
// import 'package:honeyiou/src/pages/others/review_widget.dart';
// import 'package:honeyiou/src/providers/tasks_provider.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';

// import 'new_terms_chat.dart';
// import 'pay_your_partner.dart';
// import 'start_negociation_task.dart';

// class TaskList extends StatefulWidget {

//   final List<TaskData> finalList;

//   const TaskList({super.key, required  this.finalList});



//   @override
//   _TaskListState createState() => _TaskListState(
//     finalList
//   );
// }


// class _TaskListState extends State<TaskList> with TickerProviderStateMixin{
//   final List<TaskData> finalList;
//   _TaskListState(this.finalList);

//   bool? imageRewardUrl;
//   AnimationController? _controller;
//   Animation<double>? _animation;
//   List<TaskData> listQuery = [];


//   @override
//   void initState() {
//     _controller = AnimationController(
//        vsync: this,
//        duration: const Duration(milliseconds: 1000),
//      );
//      _animation  = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
//      _controller?.forward();

    



//     super.initState();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations? localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
//     String lang = Lang.lang; 
//     print(lang);
//     //final pref = UserPreferences();
//     //String user = pref.uid;
//     UsuarioProvider(uid: user, lang: lang).language();
//     var size = MediaQuery.of(context).size;
//     final double itemHeight = (size.height - kToolbarHeight - 24) / 4.5;
//     final double itemWidth = size.width / 2;
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height*0.77,
//       child:  GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 15.0,      
//           crossAxisSpacing: 2.0,
//         ),
//         itemBuilder: (context, index){
//           return  _card(finalList[index], localizations);
//         },
//         itemCount: finalList.length,
//       )
//     );
//   }

//   //OnPressed Navigate to the diferents screens
//   void _onPressed(TaskData task, context, ){
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
//     String formattedDate;
//     final pref = UserPreferences();
//     String user = pref.uid;
//     if(task.deliveryTime != null){
//       DateTime dateTime = task.deliveryTime.toDate();
//       var formatter = DateFormat("MMM d' at 'HH':'mm aaa");
//       formattedDate = formatter.format(dateTime);
//     }else{
//       formattedDate = localizations.t("home_page.noDate");
//     }
//     final taskProvider = Provider.of<TasksListProvider>(context, listen: false);      
//     taskProvider.dateTime = task.dateTime;
//     taskProvider.deliveryTime = task.deliveryTime ;
//     taskProvider.receiverUid = task.receiverUid;
//     taskProvider.rewardDescription = task.rewardDescription;
//     taskProvider.rewardImgUrl = task.rewardImgUrl;
//     taskProvider.senderUid = task.senderUid;
//     taskProvider.status = task.status;
//     taskProvider.title = task.title;
//     taskProvider.idTask = task.uidTask;  
//     if (task.senderUid== user){
//       if(task.status == 'not_started'){
//         Navigator.of(context).push(CupertinoPageRoute(builder: (context){
//           return PayYourPartnerPage(
//             task: task,
//           );
//         }));
//       }else if(task.status == 'open' ||task.status == 'paid_upfront'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if(task.status == 'pending_receiver'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if(task.status == 'started'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if(task.status == 'rejected'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if (task.status == 'completed'){  
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return Review(
//             status: task.status,
//             reviewDescription: task.reviewDescription ,
//             reviewValue: task.reviewValue.toString() ,
//             taskDate:formattedDate ,
//             task: task,
//           );
//         }));
//       }else if(task.status == 'reviewed'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return Review(
//             status: task.status,
//             reviewDescription: task.reviewDescription ,
//             reviewValue: task.reviewValue.toString() ,
//             taskDate:formattedDate ,
//             task: task,
//           );
//         }));
//       }
//     }else if (task.receiverUid == user){
//       if(task.status== 'not_started'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return StartNegociationPage(
//             task: task,
//           );
//         }));
//       }else if(task.status == 'open' ||task.status == 'paid_upfront'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if(task.status == 'pending_receiver'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if(task.status == 'started'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if(task.status == 'rejected'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return ChatPage();
//         }));
//       }else if (task.status == 'completed'){  
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return Review(
//             status: task.status,
//             reviewDescription: task.reviewDescription ,
//             reviewValue: task.reviewValue.toString() ,
//             taskDate:formattedDate ,
//             task: task,
//           );
//         }));
//       }else if(task.status == 'reviewed'){
//         Navigator.of(context).push(CupertinoPageRoute(builder:(context){
//           return Review(
//             status: task.status,
//             reviewDescription: task.reviewDescription ,
//             reviewValue: task.reviewValue.toString() ,
//             taskDate:formattedDate ,
//             task: task,
//           );
//         }));
//       }
//     }      
//   }
  
//   Widget _card(TaskData task, localizations) {
//     return
//       FadeTransition(
//         opacity: _animation,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0),
//             child: InkWell(
//               onTap: (){
//                 _onPressed(task, context, );         
//               },
//               child: Container(
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
//                 height: MediaQuery.of(context).size.height * 0.05,
//                 width: MediaQuery.of(context).size.width,
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0)
//                   ),
//                   elevation: 20.0,
//                   color: Color(0xff393939),
//                   margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         child: GestureDetector(
//                           onTap: (){
//                             _onPressed(task, context, );         
//                           },
//                           child: titleTask(task, localizations)
//                         )
//                       ),
//                       //Positioned(left: 10.0, top:5.0, child: LeadingWidget(receiverUid: task.receiverUid, senderUid: task.senderUid)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ),
//       );
//     }

//   Widget titleTask(TaskData task, localizations) {
//     if (task.rewardImgUrl == '') {
//       imageRewardUrl = false;
//     }
//     if (task.rewardImgUrl != '') {
//       imageRewardUrl = true;
//     }
//     final pref = UserPreferences();
//     String user = pref.uid;
//     if (task.senderUid== user) {
//       if (task.status== 'not_started') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations, task.receiverUid)
//         );
//       } else if (task.status == 'open' ||task.status == 'paid_upfront') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations, task.receiverUid)
//         );
//       } else if (task.status == 'pending_receiver') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations, task.receiverUid)
//         );
//       } else if (task.status == 'started') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.receiverUid)
//         );
//       } else if (task.status == 'rejected') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.receiverUid)
//         );
//       }else if (task.status == 'completed') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.receiverUid)
//         );
//       } else if(task.status == 'reviewed'){
//          return item(task, localizations, task.receiverUid);    
//       } 
//     } else if (task.receiverUid == user) {
//       if (task.status == 'not_started') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.senderUid)
//         );
//       } else if (task.status == 'open' || task.status == 'paid_upfront') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.senderUid)
//         );
//       } else if (task.status == 'pending_receiver') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations, task.senderUid)
//         );
//       } else if (task.status == 'started') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.senderUid)
//         );
//       } else if (task.status == 'rejected') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.senderUid)
//         );
//       } else if (task.status == 'completed') {
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations, task.senderUid)
//         );
//       } else if(task.status == "reviewed"){
//         return GestureDetector(
//           onTap: (){
//             _onPressed(task, context, );
//           },
//           child: item(task, localizations,  task.senderUid)
//         );
//       } 
//     } else {
//       return Text(
//         'No Task',
//         style: TextStyle(color: Colors.white),
//       );
//     }
//   }

//   Widget item(TaskData task, localizations,  String partnerUid){
//     return Container(
//       width: MediaQuery.of(context).size.width*0.45,
//       height: MediaQuery.of(context).size.height*0.35,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0)
//       ),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20.0),
//             child: Opacity(
//               opacity: 0.2,
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width*0.45,
//                 height: MediaQuery.of(context).size.height*0.35,
//                 child: task.rewardImgUrl != null ?  Image(
//                   image:NetworkImage(task.rewardImgUrl),
//                   fit: BoxFit.cover, 
//                 ) : Container(),
//               ),
//             ),
//           ),
//           Positioned(
//             left:5.0,
//             top: 5.0,
//             child: StreamBuilder(
//               stream: UsuarioProvider().getPartnerData(partnerUid),
//               builder:(context, snapPartner){
//                 if(snapPartner.connectionState == ConnectionState.waiting){
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 return SizedBox(
//                   width: MediaQuery.of(context).size.width*0.45,
//                   child: Row(
//                     children: [
//                       CircleAvatarWidget(
//                         imageUrl: snapPartner.data() as Map<String,dynamic>["photo_url"],
//                         radius: 20.0,
//                       ),
//                       SizedBox(width: 5.0,),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width*0.28,
//                         child: RichText(
//                           overflow: TextOverflow.ellipsis,
//                           text: TextSpan(
//                             children: [
//                               TextSpan(text: " ${snapPartner.data() as Map<String,dynamic>["name"]} ", style: TextStyle(color:Colors.white, fontFamily: "Sans", fontWeight: FontWeight.bold, fontSize: 14))
//                             ],
//                           )
//                         ),
//                       )
//                     ],
//                   )
//                 );
//               }
//             ),
//           ),
//           Positioned(
//             left:5,
//             bottom: 10.0,
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width*0.4,
//               child: Text(task.title,style: TextStyle(color:Colors.white, fontFamily: "Sans", fontWeight: FontWeight.bold, fontSize: 17.0 ), maxLines: 2,overflow: TextOverflow.ellipsis,)
//             ),
//           )
//         ],
//       ),
//     );
//   }
  
// }