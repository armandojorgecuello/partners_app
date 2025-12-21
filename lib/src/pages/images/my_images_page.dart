// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:image_picker/image_picker.dart';

// import 'package:honeyiou/src/pages/others/settings_app.dart';
// import 'package:honeyiou/src/providers/usuarios_provider.dart';
// import 'package:honeyiou/utils/locale_app.dart';
// import 'package:honeyiou/utils/shared_preferences.dart';

// import 'grid_images.dart';

// class ImagesPage extends StatefulWidget {
//   const ImagesPage({Key key}) : super(key: key);

//   @override
//   _ImagesPageState createState() => _ImagesPageState();
// }

// class _ImagesPageState extends State<ImagesPage> {
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
//     final userImages = UsuarioProvider().getUserImages;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xff393939),
//         // backgroundColor: Colors.grey[900],
//         appBar: AppBar(
//           titleSpacing: 10.0,
//           title: Row(
//             children: [
//               GestureDetector(
//                 child: SizedBox(
//                   height: 40.0,
//                   width: MediaQuery.of(context).size.width*0.21,
//                   // color:Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.arrow_back_ios, color: Colors.white),
//                       Text(
//                         localizations.t('images.back'),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () => Navigator.of(context).pop(),
//               ),
//               SizedBox(width:MediaQuery.of(context).size.width*0.13),
//               Text(localizations.t('images.title'),),
//               Expanded(child: Container(),),
//               GestureDetector(
//                 child: Image(
//                   image: AssetImage('assets/image/Camera.png',),
//                   // ,width: 24.0,
//                   height: 24.0,
//                 ),
//                 onTap:(){
//                   _select(localizations);
//                 }
//               ),
//             ],
//           ),
//           centerTitle: false,
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xff7a1418),
//         ),
//         body: ImageGridItem()
//       ),
//     );
//   }

//   Future<void> _select(localizations) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//       final pref = UserPreferences();
//       String user = pref.uid;
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 GestureDetector(
//                   child: Text(localizations.t('images.cameraText')),
//                   onTap: () => [
//                     pickImageFrom(ImageSource.camera, user, localizations),
//                     Navigator.of(context).pop(),
//                   ]
//                 ),
//                 SizedBox(
//                   height: 05.0,
//                 ),
//                 Divider(),
//                 SizedBox(
//                   height: 05.0,
//                 ),
//                 GestureDetector(
//                   child: Text(localizations.t('images.galleryText')),
//                   onTap: () => [
//                     pickImageFrom(ImageSource.gallery, user, localizations),
//                     Navigator.of(context).pop(),
//                   ]
//                 )
//               ]
//             )
//           )
//         );
//       }
//     );
//   }

//   File galleryFile;
//   //seleccionar foto de la galeria o camara
//   pickImageFrom(ImageSource source, uid, localizations) async {
//     var imageFile = await ImagePicker.pickImage(source: source);
//     setState(() {
//       galleryFile = imageFile;
//       UsuarioProvider().uploadImageFromGalleryOrCameraStorage(galleryFile, uid).whenComplete(() => 
//         Scaffold.of(context)
//           .showSnackBar(
//             SnackBar(
//               duration: Duration(seconds: 4),
//               content: (
//                 Text(localizations.t('images.snackBarText'), style: TextStyle(color:Colors.white),)
//               )
//             )
//           )
//       );
//     });
//   }
// }
