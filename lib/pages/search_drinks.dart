import 'package:cocktailer_project/pages/detail_drinks.dart';
import 'package:cocktailer_project/pages/search_screen.dart';
import 'package:cocktailer_project/repository/cocktail_json.dart';
import 'package:flutter/material.dart';

import '../repository/cocktailItem.dart';

class SearchCocktail extends StatefulWidget {
  const SearchCocktail({Key? key}) : super(key: key);

  @override
  State<SearchCocktail> createState() => _SearchCocktailState();
}

class _SearchCocktailState extends State<SearchCocktail> {
  late Cocktail currentCoctail;
  Future<List<Cocktail>>? cocktail;
  Future<List<Cocktail>>? clickedCocktail;
  @override
  void initState() {
    super.initState();
    cocktail = getJSONData();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      //leading:, 앞쪽 배치
      backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          print('click');
        },
        child: SearchScreen(),
      ),
    );
  }

  _makeDataList(List<Cocktail> datas) {
    return ListView.separated(
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
                    tag: datas[index].id!,
                    child: Image.network(
                      "${datas[index].imageSource}",
                      width: 100,
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        Text(
                          datas[index].engName!,
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
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
    );
  }

  _loadcontents() {
    return CocktailItem().loadCocktailFromLocation();
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        future: cocktail,
        builder: (context, dynamic snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("데이터 오류"),
            );
          }
          if (snapshot.hasData) {
            List<Cocktail> datas = snapshot.data;
            return _makeDataList(datas);
          }
          return const Center(
            child: Text("해당 지역의 데이터가 없습니다."),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _appbarWidget(),
      body: SearchScreen(),
    );
  }
}
