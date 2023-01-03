import 'dart:async';

import 'package:cocktailer_project/pages/detail_drinks.dart';
import 'package:cocktailer_project/repository/cocktail_json.dart';
import 'package:flutter/material.dart';

class SearchCocktailScreen extends StatefulWidget {
  const SearchCocktailScreen({super.key});

  @override
  State<SearchCocktailScreen> createState() => _SearchCocktailScreenState();
}

class _SearchCocktailScreenState extends State<SearchCocktailScreen> {
  final TextEditingController _filter = TextEditingController(); //검색 컨트롤러
  FocusNode focusNode = FocusNode(); //현재 커서가 있는지 없는지
  String _searchText = "";
  late Future<List<Cocktail>> cocktail;
  StreamController<List<Cocktail>> controller =
      StreamController<List<Cocktail>>.broadcast();
  late Stream<List<Cocktail>> searchCocktail = controller.stream;

  _SearchCocktailScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    cocktail = getJSONData();
    searchCocktail = Stream.fromFuture(cocktail);
  }

//검색위젯을 컨트롤하는 _filter가 변화를 감지하여 _searchText의 상태를 변화시키는 코드

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: searchCocktail,
      builder: ((context, dynamic snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data);
      }),
    );
  }

  Widget _buildList(BuildContext context, List<Cocktail> snapshot) {
    List<Cocktail> searchResult = [];
    for (Cocktail d in snapshot) {
      if (d.engName.toLowerCase().toString().contains(_searchText)) {
        searchResult.add(d);
      }
    }
    return _makeDataList(searchResult);
  }

  _makeDataList(List<Cocktail> datas) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        //상하, 좌우만 패딩 주는거
        //리스트뷰에서 항목사이에 라인을 그어주는게 separated임
        itemBuilder: (BuildContext _context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DetailCocktail(
                  data: datas[index],
                );
              }));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    //가장짜리 깎아주는거
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      tag: datas[index].id,
                      child: Image.network(
                        "${datas[index].imageSource}",
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Center(
                                  child: Text(
                                "이미지 없음",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //칼럼은 아래로 추가 즉 main~이 세로정렬임, 그래서 cross~
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            datas[index].engName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${datas[index].korName}",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${datas[index].ingredient1!}, ${datas[index].ingredient2!} ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext _context, int index) {
          return Container(
            height: 1,
            color: Colors.black.withOpacity(0.3),
          );
        },
        itemCount: datas.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: TextField(
                  focusNode: focusNode,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  autofocus: true,
                  controller: _filter,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white60,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    ),
                    suffixIcon: focusNode.hasFocus
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _filter.clear();
                                _searchText = "";
                              });
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 20,
                              color: Colors.black,
                            ),
                          )
                        : Container(),
                    hintText: '검색',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              focusNode.hasFocus
                  ? Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _filter.clear();
                            _searchText = "";
                            focusNode.unfocus();
                          });
                        },
                        child: Text(
                          "취소",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 0,
                      child: Container(),
                    ),
            ],
          ),
        ),
        _buildBody(context),
      ],
    );
  }
}
