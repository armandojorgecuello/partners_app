// import 'package:flutter/material.dart';

// import '../data_models/country.dart';

// class SearchCountryTF extends StatelessWidget {
//   final TextEditingController controller;

//   const SearchCountryTF({Key key, this.controller}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//       const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 2.0, right: 8.0),
//       child: Card(
//         child: TextFormField(
//           autofocus: false,
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: 'Search your country',
//             contentPadding: const EdgeInsets.only(
//                 left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
//             border: InputBorder.none,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PhoneNumberField extends StatelessWidget {
//   final TextEditingController controller;
//   final String prefix;

//   const PhoneNumberField({Key key, this.controller, this.prefix})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.0,
//       width: MediaQuery.of(context).size.width*0.6,
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomRight:Radius.circular(50.0), topRight: Radius.circular(50.0))),
//         child: Row(
//           children: <Widget>[
//             Text("  $prefix  ", style: TextStyle(fontSize: 16.0)),
//             SizedBox(width: 8.0),
//             Expanded(
//               child: TextFormField(
//                 controller: controller,
//                 autofocus: false,
//                 keyboardType: TextInputType.phone,
//                 key: Key('EnterPhone-TextFormField'),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   errorMaxLines: 1,
//                 ),
//               ),
//             ),
//           ],
//         ),
//     );
//   }
// }

// class SubTitle extends StatelessWidget {
//   final String text;

//   const SubTitle({Key key, this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//         alignment: Alignment.centerLeft,
//         child: Text(' $text',
//             style: TextStyle(color: Colors.white, fontSize: 14.0)));
//   }
// }

// class ShowSelectedCountry extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Country country;

//   const ShowSelectedCountry({Key key, this.onPressed, this.country})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.0,
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft:Radius.circular(50.0), topLeft: Radius.circular(50.0))),
//       width: MediaQuery.of(context).size.width*0.3,
//       child: InkWell(
//         onTap: onPressed,
//         child: Padding(
//           padding: const EdgeInsets.only(
//               left: 4.0, right: 10.0, top: 8.0, bottom: 8.0),
//           child: Row(
//             children: <Widget>[
//               Expanded(child: Text(' ${country.flag ?? ''}  ${country.dialCode ?? '+1'} ')),
//               Icon(Icons.arrow_drop_down, size: 24.0)
//             ],
//           ),
//       //     child:CountryCodePicker(
//       //    onChanged: print,
//       //    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//       //    initialSelection: 'IT',
//       //    favorite: ['+39','FR'],
//       //    // optional. Shows only country name and flag
//       //    showCountryOnly: false,
//       //    // optional. Shows only country name and flag when popup is closed.
//       //    showOnlyCountryWhenClosed: false,
//       //    // optional. aligns the flag and the Text left
//       //    alignLeft: false,
//       //  ),
//         ),
//       ),
//     );
//   }
// }

// class SelectableWidget extends StatelessWidget {
//   final Function(Country) selectThisCountry;
//   final Country country;

//   const SelectableWidget({Key key, this.selectThisCountry, this.country})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       type: MaterialType.canvas,
//       child: InkWell(
//         onTap: () => selectThisCountry(country), //selectThisCountry(country),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Text(
//             "  ${country.flag}  ${country.name} (${country.dialCode})",
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w500),
//           ),
//         ),
//       ),
//     );
//   }
// }
