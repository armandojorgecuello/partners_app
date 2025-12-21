import 'dart:convert' show json;
import 'package:geolocator/geolocator.dart';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:flutter/widgets.dart' show TextEditingController, debugPrint;
import 'package:honey_iou_updated/phone_auth_temp/data_models/country.dart';

class CountryProvider with ChangeNotifier {
  String? phoneCode;  
  String? flagUrl;

  /// loading countries data from json
  /// setting up listeners
  ///
  
  
  CountryProvider() {
    loadCountriesFromJSON();
    searchController.addListener(_search);
  }

  List<Country> _countries = [];
  List<Country> get countries => _countries;

  List<Country> _searchResults = [];

  List<Country> get searchResults => _searchResults;

  set searchResults(List<Country> value) {
    _searchResults = value;
    notifyListeners();
  }

  Country _selectedCountry = Country();

  Country get selectedCountry => _selectedCountry ;

  set selectedCountry(Country value) {
    _selectedCountry = value;
    notifyListeners();
  }

  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;
  
   geolocator()async{
    Position   position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var status = await Geolocator.checkPermission();
    var countryData;
    if (status == LocationPermission.always) {
      // Permission granted and location enabled
    //   final coordinates = Coordinates(position.latitude, position.longitude);
    //   var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //   var first = addresses.first;
    //   var geoCoderCode = first.countryCode ;
    //   for (var countryInfo in _countries) {
    //     if ((countryInfo.code).toLowerCase() == (geoCoderCode).toLowerCase() ?? 'us') {
    //       return countryData = countryInfo;
    //     }
    //   }    
    // }
    // if (countryData == null){
    //   for (var countryInfo in _countries) {
    //     if ((countryInfo.code).toLowerCase() ==  'us') {
    //       return countryData = countryInfo;
    //     }
    //   } 
    // }
    // return countryData;
  }
   }

  Future loadCountriesFromJSON() async {

    // try {
    //   if (countries.isEmpty) {
    //     var file =
    //         await rootBundle.loadString('data/country_phone_codes.json');
    //     var countriesJson = json.decode(file);
    //     List<Country> listOfCountries = [];
    //     for (var country in countriesJson) {
    //       listOfCountries.add(Country.fromJson(country));
    //     }
    //     _countries = listOfCountries;
    //     var countryData;
    //     try {
        // Position   position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        // var status = await Geolocator().checkGeolocationPermissionStatus();
        // if (status == GeolocationStatus.granted) {
        //   // Permission granted and location enabled
        //   final coordinates = Coordinates(position.latitude, position.longitude);
        //   var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        //   var first = addresses.first;
        //   var geoCoderCode = first.countryCode ;
        //   for (var countryInfo in _countries) {
        //     if ((countryInfo.code).toLowerCase() == (geoCoderCode).toLowerCase() ?? 'us') {
        //       countryData = countryInfo;
        //     }
        //   }    
        // } else{
        //   for (var countryInfo in _countries) {
        //     if ((countryInfo.code).toLowerCase() == 'us') {
        //       countryData = countryInfo;
        //     }
        //   }  
        // } 
    //     } on PlatformException catch(e){
    //       if (e.code == 'PERMISSION_DENIED') {
    //         for (var countryInfo in _countries) {
    //         if ((countryInfo.code).toLowerCase() ==  'us') {
    //           countryData = countryInfo;
    //         }
    //       } 
    //       } else {
    //         print(e.code);
    //       }
    //     }
             
            
    //     notifyListeners();
    //     selectedCountry = countryData ?? _countries[234] ;
    //     searchResults = _countries;
            
        
    //   }
    // } catch (err) {
    //   debugPrint("Unable to load countries data");
    // }
  }
  // Future 
  ///  This will be the listener for searching the query entered by user for their country, (dialog pop-up),
  ///  searches for the query and returns list of countries matching the query by adding the results to the sink of [searchResults]
  void _search() {
    String query = searchController.text;
    if (query.isEmpty || query.length == 1) {
      searchResults = countries;
    } else {
      List<Country> results = [];
      for (var c in countries) {
        if (c.toString().toLowerCase().contains(query.toLowerCase())) {
          results.add(c);
        }
      }
      searchResults = results;
    }
  }

  void resetSearch() {
    searchResults = countries;
  }
}
