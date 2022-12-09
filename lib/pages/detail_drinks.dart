import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailCocktail extends StatefulWidget {
  Map<String, String> data;

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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Hero(
            tag: widget.data["idDrink"]!,
            child: Image.asset(
              widget.data["strImageSource"]!,
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
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
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "${widget.data["strDrink"]}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 5,),
          Text(
            "Glass : ${widget.data["strGlass"]}",
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
                  " ${widget.data["strInstructions"]}",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentDetailIngredientAndMeasure() {
    int index = _measureItemCounter(widget.data);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Ingredient",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            itemCount: index,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${widget.data["strIngredient${index + 1}"]!} : ${widget.data["strMeasure${index + 1}"]}",
                      style: TextStyle(fontSize: 17),
                    ),
                    _line(),
                  ],
                ),
              );
            },
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
              _contentDetailIngredientAndMeasure(),
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

_measureItemCounter(Map<String, String> data) {
  int count = 0;
  int i = 1;
  while (data["strIngredient${i}"] != null) {
    i++;
  }
  count = i - 1;
  return count;
}
