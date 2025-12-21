class CountryApiData{
  List<CountryData> dataCountry = [];

  CountryApiData();

  CountryApiData.fromJsonList(List<dynamic> jsonList){

    for (var data in jsonList) {
      final countryData = CountryData.fromJsonMap(data);
      dataCountry.add(countryData);
    }

  }


}

class CountryData {
  String? name;
  String? alpha2Code;
  String? alpha3Code;
  String? capital;
  String? region;
  String? subregion;
  int? population;
  String? demonym;
  double? area;
  double? gini;
  String? nativeName;
  String? numericCode;
  String? flag;
  String? cioc;
  List<double>? latlng;
  List<String>? callingCodes;
  List<String>? borders;
  List<String>? topLevelDomain;
  List<String>? altSpellings;
  List<String>? timezones;

  CountryData({
    required this.name,
    required this.topLevelDomain,
    required this.alpha2Code,
    required this.alpha3Code,
    required this.callingCodes,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.subregion,
    required this.population,
    required this.latlng,
    required this.demonym,
    required this.area,
    required this.gini,
    required this.timezones,
    required this.borders,
    required this.nativeName,
    required this.numericCode,
    required this.flag,
    required this.cioc,
  });

  CountryData.fromJsonMap(Map<String, dynamic> json){
    name            = json['name'];
    topLevelDomain  = json['topLevelDomain'];
    alpha2Code      = json['alpha2Code'];
    alpha3Code      = json['alpha3Code'];
    callingCodes    = json['callingCodes'].cast<String>();
    capital         = json['capital'];
    altSpellings    = json['altSpellings'];
    region          = json['region'];
    subregion       = json['subregion'];  
    population      = json['population'];  
    latlng          = json['latlng'];  
    demonym         = json['demonym'];    
    area            = json['area'];  
    gini            = json['gini'];    
    timezones       = json['timezones'];    
    borders         = json['borders'];    
    nativeName      = json['nativeName'];      
    numericCode     = json['numericCode'];      
    flag            = json['flag'];
    cioc            = json['cioc'];
    alpha2Code=json['alpha2Code'];
    alpha3Code=json['alpha3Code'];
    area=json['area'];
    gini=json['gini'];  
    
    
  }

}





