import 'package:cocktailer_project/repository/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late Map<String, String> data;
  //late List data;

  @override
  initState() {
    super.initState();
    //data = _loadUserData();
    //data = new List.empty(growable: true);
    getJSONData();
  }

  _loadUserData() {
    return UserData().loadUserData();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: Text(
        "My Bar",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _profile() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SvgPicture.asset(
              "assets/svg/user_on.svg",
              color: Colors.black,
              width: 50,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NicName",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "bottleNumber : 17",
                style: TextStyle(
                    fontSize: 15, color: Colors.black.withOpacity(0.7)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuWidget(String menutitle, String sub) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 80,
        padding: EdgeInsets.all(20),
        color: Colors.black.withOpacity(0.2),
        child: Row(
          children: [
            Expanded(
              child: Text(
                menutitle,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.white,
                child: Center(
                    child: Text(
                  sub,
                  style: TextStyle(color: Colors.grey),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
        margin: EdgeInsets.all(15),
        //color: Colors.red,
        child: SafeArea(
          child: Column(
            children: [
              _profile(),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                      color: Colors.black.withOpacity(0.3), thickness: 1)),
              _menuWidget("My Bar", "10"),
              SizedBox(height: 10),
              _menuWidget("Favourite Cocktail", "5"),
              SizedBox(height: 10),
              _menuWidget("Tips", "20"),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }

  Future<String> getJSONData() async {
    var url = 'http://192.168.219.111:8080/ingredients';
    var response = await http.get(Uri.parse(url));
    print(response.body);
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON;
      print(result);
      //5. 가져온 데이터를 리스트에 저장함
      data.addAll(result);
    });
    return response.body;
  }
}
