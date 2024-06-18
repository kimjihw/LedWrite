import 'package:flutter/material.dart';

class ColorOptionScreen extends StatelessWidget {
  final Function(Color) onColorChanged;
  final Function(Color) onColorBgChanged;
  final Function(String) onLottieBgChanged;
  final List<Color> colors;
  final List<Color> colors_bg;
  final List<String> lottie_bg;

  const ColorOptionScreen({super.key,
    required this.onColorChanged,
    required this.colors,
    required this.colors_bg,
    required this.lottie_bg,
    required this.onColorBgChanged,
    required this.onLottieBgChanged});

  Widget _containerBg(Color color, Widget child) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }

  Widget _baseContainer(String type, List<dynamic> list) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
        color: Colors.grey[900],
      ),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          if (type == "color")
            for (var color in list)
              _buildGestureDetector(
                onTap: () {
                  onColorChanged(color);
                },
                child: _containerBg(
                  Colors.white,
                  _containerBg(color, Container()),
                ),
              )
          else
            if (type == "color_bg")
              for (var color in list)
                _buildGestureDetector(
                  onTap: () {
                    onColorBgChanged(color);
                  },
                  child: _containerBg(
                    Colors.white,
                    _containerBg(color, Container()),
                  ),
                )
            else
              if(type == "lottie_bg")
                for (var lottie in list)
                  IconButton(onPressed: () {
                    onLottieBgChanged(lottie);
                  }, icon: Image.network("https://www.korea.kr/newsWeb/resources/temp/images/000332/01.jpg")),
        ],
      ),
    );
  }

  Widget _buildGestureDetector({
    required Function() onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }

  Widget _topContainerBg(String text){
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _topContainerBg("글자 색상"),
            _baseContainer("color", colors),
            _topContainerBg("배경 색상"),
            _baseContainer("color_bg", colors_bg),
            // Container(
            //     margin: const EdgeInsets.all(10),
            //     alignment: Alignment.centerLeft,
            //     child: Text("배경 애니메이션",
            //         style: TextStyle(color: Colors.black, fontSize: 20))),
            // _baseContainer("lottie_bg", lottie_bg),
          ],
        ),
      ),
    );
  }
}
