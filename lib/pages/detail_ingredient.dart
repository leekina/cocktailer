import 'package:cocktailer_project/repository/ingredient_json.dart';
import 'package:flutter/material.dart';

class DetailIngredient extends StatefulWidget {
  Ingredient data;
  DetailIngredient({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailIngredient> createState() => _DetailIngredientState();
}

class _DetailIngredientState extends State<DetailIngredient> {
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
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
        ),
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
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Tag : ${widget.data.ingredientType}",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Alc : ${widget.data.ingredientDescription}",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _contentDetailName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "${widget.data.engName}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "${widget.data.korName}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _otherCellContents() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "만들 수 있는 칵테일",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            "모두보기",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
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
              _line(),
              _contentDetail(),
              _line(),
              _otherCellContents(),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate(List.generate(10, (index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      child: Container(
                        color: Colors.grey,
                        height: 120,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    Text(
                      "칵테일 이름",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            })),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          ),
        )
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
