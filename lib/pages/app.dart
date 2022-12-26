import 'package:cocktailer_project/pages/home.dart';
import 'package:cocktailer_project/pages/search_drinks.dart';
import 'package:cocktailer_project/pages/search_ingredient.dart';
import 'package:cocktailer_project/pages/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;

  }

  //앱바


  Widget _bodyWidget() {
    switch(_currentPageIndex){
      case 0:
        return Home();
        break;
      case 1:
        return SearchIngredient();
        break;
      case 2:
        return SearchCocktail();
        break;
      case 3:
        return Container();
        break;
      case 4:
        return UserInfo();
        break;
    }
    return Container();
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_off.svg",
            width: 22,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_on.svg",
            width: 22,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        label: label);
  }

  Widget _BottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        print(index);
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedFontSize: 12,
      currentIndex: _currentPageIndex,
      selectedItemColor: Colors.black,
      items: [
        _bottomNavigationBarItem("home", "홈"),
        _bottomNavigationBarItem("notes", "재료"),
        _bottomNavigationBarItem("cocktail", "칵테일"),
        _bottomNavigationBarItem("chat", "커뮤니티"),
        _bottomNavigationBarItem("user", "나의 술장"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _BottomNavigationBarWidget(),
    );
  }
}
