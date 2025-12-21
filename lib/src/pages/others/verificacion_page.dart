// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_verification_code/flutter_verification_code.dart';
// import 'package:honeyiou/src/providers/login_provider.dart';
// import 'package:provider/provider.dart';



// class ValidationNumber extends StatefulWidget {
//   const ValidationNumber({super.key});


//   @override
//   _ValidationNumberState createState() => _ValidationNumberState();
// }



// class _ValidationNumberState extends State<ValidationNumber> {

//   String smscode;
//   bool _onEditing = false;
//   FirebaseAuth _auth;


//   @override
//   Widget build(BuildContext context) {

//     final query = MediaQuery.of(context).size;
//     final phoneAuthProvider = Provider.of<LoginState>(context, listen: false);
  

//     return SafeArea(
//           child: Scaffold(
//         // backgroundColor: Colors.black.withOpacity(0.4),
//         //appBar: AppBar(
//        //   title: Text('My profile'),
//        //   centerTitle: true,
//         //  backgroundColor: Colors.transparent,
//           //toolbarOpacity: 0.0,
//          //leading: Row(
//            // children: <Widget>[
//               //Text('Back'),
//              // Icon(Icons.arrow_back_ios),
//            // ],
//           //),
//         //),

//         body: SingleChildScrollView(
//                   child: Stack(
//                     children: <Widget>[
//                        _builbackground(),
//                        _crearTexto(),
//                        //_codeValue()
//                        //_buildSocialMediaButton()
//                        ],
//                      ),
//                    ),
//                  ),
//                );
//              }

//   Widget _crearTexto( ){
//     return  Center(
        
//           child: Column(
//                   children: <Widget>[
//                     SizedBox(height: 110.0,),
//                     Text("Honey IOU", style:TextStyle(fontFamily: 'Yesteryear', fontSize: 50.0, color: Colors.white)  ,),
//                     SizedBox(height: 120,),
//                     Text('Enter Your Validation Code', style: TextStyle(fontSize: 20.0,color: Colors.white),),
//                     SizedBox(height: 40.0,),
//                     SizedBox(height: 40.0,),
//                     Text("I  haven't received a validation code Resent", style: TextStyle(fontSize: 15.0, color: Colors.white),)
//                   ],
//                 ),
        
//             );
//           }

//   Widget _builbackground(){

//     return Container(
//             width:MediaQuery.of(context).size.width,
//             height:MediaQuery.of(context).size.height,
//             color: Colors.black,
//               child: SingleChildScrollView(
//                                 child: Image(
//                                 image: AssetImage("assets/image/Screenshot1.png"),
//                 ),
//               ),
//             );
//           }

//  Widget _codeValue(query){

//    return SingleChildScrollView(
//      child:Column(
//        children: <Widget>[
//           Column(
//     children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           // child: Text(
//             // 'Enter your code',
//             // style: TextStyle(fontSize: 20.0),
//           // ),
//         ),
//       ),
//       VerificationCode(

//         itemDecoration: BoxDecoration(
//           shape: BoxShape.circle, 
//           color: Colors.white
//                   ),
//         keyboardType: TextInputType.number,
//         length: 6,
//         autofocus: false,
//         onCompleted: (String value ) async {
        
//           setState(() {
//             smscode = value;
//           });
//             // LoginState().smsCodeDialog(context);
//                   },
//         onEditing: (bool value) {

//           setState(() {
//             _onEditing = value;
//           });
//         },
//       ),
//       (_onEditing != true)
//           ? Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: Container(               ),
//               ),
//             )
//           : Container(
              
//             ),
//        ],
//      )
//     ] 
//   ) 
// );

// }

 

// }