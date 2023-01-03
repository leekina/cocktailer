import 'package:cocktailer_project/pages/search_drinks_body.dart';
import 'package:flutter/material.dart';

class SearchCocktail extends StatefulWidget {
  const SearchCocktail({Key? key}) : super(key: key);

  @override
  State<SearchCocktail> createState() => _SearchCocktailState();
}

class _SearchCocktailState extends State<SearchCocktail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchCocktailScreen(),
    );
  }
}
