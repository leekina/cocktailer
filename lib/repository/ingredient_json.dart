import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class Ingredient {
  String id;
  String? korName;
  String engName = "";
  String? ingredientDescription;
  String? ingredientType;
  String? imageSource;

  Ingredient({
    required this.id,
    this.korName,
    required this.engName,
    this.ingredientDescription,
    this.ingredientType,
    this.imageSource,
  });
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'].toString(),
      korName: json['korName'],
      engName: json['engName'],
      imageSource: json['imageSource'],
      ingredientDescription: json['ingredientType'],
      ingredientType: json['ingredientType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'korName': korName,
        'engName': engName,
        'ingredientDescription': ingredientDescription,
        'imageSource': imageSource,
        'ingredientType': ingredientType,
      };
}

Future<List<Ingredient>> getIngredientJSONData() async {
  var url =
      'http://cocktail-information-env.eba-kkhp89rm.ap-northeast-2.elasticbeanstalk.com/ingredient';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
    //print(response.body); // -> String형임 즉 json그대로
    List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    List<Ingredient> result =
        body.map((dynamic item) => Ingredient.fromJson(item)).toList();

    return result;
  } else {
    // 만약 응답이 OK가 아니면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

Future<dynamic> postIngredientRequestSave(Ingredient data) async {
  var url =
      'http://cocktail-information-env.eba-kkhp89rm.ap-northeast-2.elasticbeanstalk.com/cocktail/save';
  var body = jsonEncode(data.toJson());

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  print("respose : ${response.body}");
  return null;
}

Future<dynamic> postIngredientRequestEdit(Ingredient data) async {
  var url3 =
      'http://cocktail-information-env.eba-kkhp89rm.ap-northeast-2.elasticbeanstalk.com/cocktail/edait/${data.id}';
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

Map<String, dynamic> dummyIng = {
  'id': "000000",
  "korName": "재료의 한글이름을 입력하세요",
  "engName": "재료의 영어이름을 입력하세요",
  "cocktailDescription": "칵테일 만드는 순서",
  "imageSource": "이미지 링크를 입력해주세요",
  "ingredientType": "재료 타입"
};
