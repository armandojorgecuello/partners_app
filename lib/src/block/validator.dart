

// import 'dart:async';

// class Validators{

//   final validarNombre = StreamTransformer<String, String>.fromHandlers(
//     handleData: (name , sink ){

//       if (name.length >= 10 ){
//         sink.add(name);
//       }else{
//         sink.addError('Enter your name'); 
//       }


//     }
//   ); 

//   final validarPreferences = StreamTransformer<String, String>.fromHandlers(
//     handleData: (preferences , sink ){

//       if (preferences.length >= 10 ){
//         sink.add(preferences);
//       }else{
//         sink.addError('Enter your name'); 
//       }


//     }
//   ); 

//   final validarEmail = StreamTransformer<String, String>.fromHandlers(
//     handleData: (email , sink ){

//       Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//       RegExp regExp = RegExp(pattern);
      
//       if(regExp.hasMatch(email)){
//         sink.add( email );
//       }else{
//         sink.addError('Email is not correct');
//       }

//     }
//   ); 



// }
