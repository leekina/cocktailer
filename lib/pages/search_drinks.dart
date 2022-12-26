import 'package:cocktailer_project/pages/detail_drinks.dart';
import 'package:flutter/material.dart';

import '../repository/cocktailItem.dart';

class SearchCocktail extends StatefulWidget {
  const SearchCocktail({Key? key}) : super(key: key);

  @override
  State<SearchCocktail> createState() => _SearchCocktailState();
}

class _SearchCocktailState extends State<SearchCocktail> {
  @override
  void initState() {
    super.initState();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      //leading:, 앞쪽 배치
      title: GestureDetector(
          onTap: () {
            print('click');
          },
          child: TextField(style: TextStyle(color: Colors.black),)
      ),
      backgroundColor: Colors.white,
      elevation: 1, //하단 구분선
      actions: [
        //우측끝에 배치
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.tune,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _makeDataList(List<Map<String, String>> datas){
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      //상하, 좌우만 패딩 주는거
      //리스트뷰에서 항목사이에 라인을 그어주는게 separated임
      itemBuilder: (BuildContext _context, int index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return DetailCocktail(data: datas[index],);
            }));
            print(datas[index]["strDrink"]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  //가장짜리 깎아주는거
                  borderRadius:
                  const BorderRadius.all(Radius.circular(10)),
                  child: Hero(
                    tag: datas[index]["idDrink"]!,
                    child: Image.asset(
                      datas[index]["strImageSource"]!,
                      width: 100,
                      height: 100,
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
                          datas[index]["strDrink"]!,
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]["strCategory"]!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.3)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${datas[index]["strGlass"]!}",
                          style: TextStyle(fontWeight: FontWeight.w500),
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
        future: _loadcontents(),
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
            List<Map<String, String>> datas = snapshot.data;
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
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
