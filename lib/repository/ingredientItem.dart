import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IngredientItem{
  Map<String, dynamic> data = {
    "Ingredient": [
      {
        "id": "1",
        "engName": "Bombay Bramble",
        "korName": "봄베이 브램블",
        "tag1": "Gin",
        "tag2": "Sloe Gin",
        "alcohol": "37.5",
        "productDescription": "봄베이 사파이어에 라즈베리를 인퓨전 시킨 제품",
        "imagePath": "assets/ingredientImages/Bombay-Bramble.jpg"
      },
      {
        "id": "2",
        "engName": "Bombay Sapphire London Dry Gin",
        "korName": "봄베이 브램블",
        "tag1": "Gin",
        "tag2": "London Dry Gin",
        "alcohol": "45",
        "productDescription": "봄베이 사파이어에 라즈베리를 인퓨전 시킨 제품",
        "imagePath": "assets/ingredientImages/Bombay-Sapphire-London-Dry-Gin.jpg"
      },
      {
        "id": "3",
        "engName": "Amaretto",
        "korName": "아마레또",
        "tag1": "Liqueur",
        "tag2": "Amaretto",
        "alcohol": "20",
        "productDescription": "아마레또를 드카이퍼방식으로 풀어낸 리큐르",
        "imagePath": "assets/ingredientImages/De-Kuyper-Amaretto.png"
      },
      {
        "id": "4",
        "engName": "Banana liqueur",
        "korName": "드카이퍼 바나나",
        "tag1": "Liqueur",
        "tag2": "Banana Liqueur",
        "alcohol": "20",
        "productDescription": "바나나 리큐르",
        "imagePath": "assets/ingredientImages/De-Kuyper-Banana.png"
      },
    ]
  };
  Future<List<Map<String, String>>> loadIngredientFromLocation() async {
    //API통신  location값을 보내주면서
    await Future.delayed(Duration(milliseconds: 500));
    //throw Exception();
    return data["Ingredient"];
  }
}