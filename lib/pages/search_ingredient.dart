import 'package:cocktailer_project/pages/search_ingredient_body.dart';
import 'package:flutter/material.dart';

class SearchIngredient extends StatefulWidget {
  const SearchIngredient({Key? key}) : super(key: key);

  @override
  State<SearchIngredient> createState() => _SearchIngredientState();
}

class _SearchIngredientState extends State<SearchIngredient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _appbarWidget(),
      body: SearchIngredientScreen(),
    );
  }
}
