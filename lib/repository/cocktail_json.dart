import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class Cocktail {
  String? id;
  String? korName;
  String? engName;
  String? alcoholic;
  String? glass;
  String? cocktailDescription;
  String? ingredient1;
  String? ingredient2;
  String? ingredient3;
  String? ingredient4;
  String? ingredient5;
  String? ingredient6;
  String? ingredient7;
  String? ingredient8;
  String? ingredient9;
  String? ingredient10;
  String? measure1;
  String? measure2;
  String? measure3;
  String? measure4;
  String? measure5;
  String? measure6;
  String? measure7;
  String? measure8;
  String? measure9;
  String? measure10;
  String? imageSource;
  String? imageAttribution;

  Cocktail({
    required this.id,
    this.korName,
    this.engName,
    this.alcoholic,
    this.cocktailDescription,
    this.glass,
    this.imageAttribution,
    this.imageSource,
    this.ingredient1,
    this.ingredient10,
    this.ingredient2,
    this.ingredient3,
    this.ingredient4,
    this.ingredient5,
    this.ingredient6,
    this.ingredient7,
    this.ingredient8,
    this.ingredient9,
    this.measure1,
    this.measure10,
    this.measure2,
    this.measure3,
    this.measure4,
    this.measure5,
    this.measure6,
    this.measure7,
    this.measure8,
    this.measure9,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['id'].toString(),
      korName: json['korName'],
      engName: json['engName'],
      alcoholic: json['alcoholic'],
      cocktailDescription: json['cocktailDescription'],
      glass: json['glass'],
      imageAttribution: json['imageAttribution'],
      imageSource: json['imageSource'],
      ingredient1: json['ingredient1'],
      ingredient10: json['ingredient10'],
      ingredient2: json['ingredient2'],
      ingredient3: json['ingredient3'],
      ingredient4: json['ingredient4'],
      ingredient5: json['ingredient5'],
      ingredient6: json['ingredient6'],
      ingredient7: json['ingredient7'],
      ingredient8: json['ingredient8'],
      ingredient9: json['ingredient9'],
      measure1: json['measure1'],
      measure10: json['measure10'],
      measure2: json['measure2'],
      measure3: json['measure3'],
      measure4: json['measure4'],
      measure5: json['measure5'],
      measure6: json['measure6'],
      measure7: json['measure7'],
      measure8: json['measure8'],
      measure9: json['measure9'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'korName': korName,
        'engName': engName,
        'alcoholic': alcoholic,
        'cocktailDescription': cocktailDescription,
        'glass': glass,
        'imageAttribution': imageAttribution,
        'imageSource': imageSource,
        'ingredient1': ingredient1,
        'ingredient2': ingredient2,
        'ingredient3': ingredient3,
        'ingredient4': ingredient4,
        'ingredient5': ingredient5,
        'ingredient6': ingredient6,
        'ingredient7': ingredient7,
        'ingredient8': ingredient8,
        'ingredient9': ingredient9,
        'ingredient10': ingredient10,
        'measure1': measure1,
        'measure2': measure2,
        'measure3': measure3,
        'measure4': measure4,
        'measure5': measure5,
        'measure6': measure6,
        'measure7': measure7,
        'measure8': measure8,
        'measure9': measure9,
        'measure10': measure10,
      };
}

class CocktailList {
  final List<Cocktail> cocktails;

  CocktailList({
    required this.cocktails,
  });

  factory CocktailList.fromJson(List<dynamic> parsedJson) {
    List<Cocktail> cocktails = <Cocktail>[];
    return CocktailList(
      cocktails: cocktails,
    );
  }
}

Future<List<Cocktail>> getJSONData() async {
  var url2 =
      'http://cocktail-information-env.eba-kkhp89rm.ap-northeast-2.elasticbeanstalk.com/cocktail';
  final response = await http.get(Uri.parse(url2));
  if (response.statusCode == 200) {
    // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
    //print(response.body); // -> String형임 즉 json그대로
    List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    List<Cocktail> result =
        body.map((dynamic item) => Cocktail.fromJson(item)).toList();

    return result;
  } else {
    // 만약 응답이 OK가 아니면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

Future<dynamic> postRequestSave(Cocktail data) async {
  var url3 =
      'http://cocktail-information-env.eba-kkhp89rm.ap-northeast-2.elasticbeanstalk.com/cocktail/save';
  var body = jsonEncode(data.toJson());

  http.Response response = await http.post(
    Uri.parse(url3),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  print("respose : ${response.body}");
  return null;
}

Future<dynamic> postRequestSaveMultiple(List<Cocktail> data) async {
  var url3 =
      'http://cocktail-information-env.eba-kkhp89rm.ap-northeast-2.elasticbeanstalk.com/cocktail/save/multiple';
  var body = jsonEncode(data);

  http.Response response = await http.post(
    Uri.parse(url3),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  print("respose : ${response.body}");
  return null;
}

Future<dynamic> postRequestEdit(Cocktail data) async {
  var url3 =
      'http://cocktail-information-env.eba-kkhp89rm.ap-northeast-2.elasticbeanstalk.com/cocktail/edit/${data.id}';
  var body = jsonEncode(data.toJson());
  //print(body);

  http.Response response = await http.post(
    Uri.parse(url3),
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  if (response.statusCode == 200) {
    print("respose : ${response.body}");
  } else {
    // 만약 응답이 OK가 아니면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }

  return null;
}

Cocktail dummydata = Cocktail.fromJson(temp);
Map<String, dynamic> temp = {
  'id': "000000",
  "korName": "이름을 입력하세요",
  "engName": "이름을 입력하세요",
  "alcoholic": "알콜이 포함되었나요",
  "glass": "글래스",
  "cocktailDescription": "칵테일 만드는 순서",
  "ingredient1": "재료1이름",
  "ingredient2": "재료2이름",
  "ingredient3": "재료3이름",
  "ingredient4": "재료4이름",
  "ingredient5": "재료5이름",
  "ingredient6": "재료6이름",
  "ingredient7": "재료7이름",
  "ingredient8": "재료8이름",
  "ingredient9": "재료9이름",
  "ingredient10": "재료10이름",
  "measure1": "재료1의 양",
  "measure2": "재료2의 양",
  "measure3": "재료3의 양",
  "measure4": "재료4의 양",
  "measure5": "재료5의 양",
  "measure6": "재료6의 양",
  "measure7": "재료7의 양",
  "measure8": "재료8의 양",
  "measure9": "재료9의 양",
  "measure10": "재료10의 양",
  "imageAttribution": "이미지 저작권",
  "imageSource": "이미지 링크를 입력해주세요",
};
