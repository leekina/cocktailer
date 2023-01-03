import 'package:cocktailer_project/repository/cocktail_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailCocktail extends StatefulWidget {
  Cocktail data;

  DetailCocktail({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailCocktail> createState() => _DetailCocktailState();
}

class _DetailCocktailState extends State<DetailCocktail> {
  late Size? size;
  double scrollpositionToAlpha = 0;
  ScrollController _controller = ScrollController();
  late bool isMyFavoriteContent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {
        if (_controller.offset > 255) {
          scrollpositionToAlpha = 255;
        } else if (_controller.offset < 0) {
          scrollpositionToAlpha = 0;
        } else {
          scrollpositionToAlpha = _controller.offset;
        }
      });
    });
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollpositionToAlpha.toInt()),
      //투명
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        SvgPicture.asset(
          "assets/svg/heart_off.svg",
          width: 25,
          color: Colors.black.withOpacity(0.5),
        ),
        SizedBox(
          width: 15,
        )
      ],
    );
  }

  Widget _makeSliderimage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Hero(
          tag: widget.data.id,
          child: Image.network(
            "${widget.data.imageSource}",
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Text(
                    "이미지 없음",
                  )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _line() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetailName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "${widget.data.engName}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Glass : ${widget.data.glass}",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget _contentDetailInstructions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Instructions",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  " ${widget.data.cocktailDescription}",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _makeSliderimage(),
              _contentDetailName(),
              //_line(),
              //_contentDetailIngredientAndMeasure(),
              //_line(),
              _contentDetailInstructions(),
              //_otherCellContents(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
