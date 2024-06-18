import 'package:flutter/material.dart';

class TextOptionScreen extends StatelessWidget {
  const TextOptionScreen({
    Key? key,
    required this.onSizeChanged,
    required this.onFontChanged,
    required this.onSpeedChanged,
    required this.onBlinkChanged,
    required this.textSize,
    required this.textFont,
    required this.textSpeed,
    required this.textBlink,
  }) : super(key: key);

  final Function(int) onSizeChanged;
  final Function(String) onFontChanged;
  final Function(int) onSpeedChanged;
  final Function(int) onBlinkChanged;
  final List<int> textSize;
  final List<String> textFont;
  final List<int> textSpeed;
  final List<int> textBlink;

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
          if (type == "font")
            for (var font in list)
              _buildGestureDetector(
                onTap: () {
                  onFontChanged(font);
                },
                child: _containerBg(
                  Colors.white,
                  Text(
                    "Aa",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: font,
                    ),
                  ),
                ),
              )
          else if (type == "speed")
            for (var speed in list)
              _buildGestureDetector(
                onTap: () {
                  onSpeedChanged(speed);
                },
                child: _containerBg(
                  Colors.white,
                  Text(
                    "x$speed",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
          else if (type == "size")
            for (var size in list)
              _buildGestureDetector(
                onTap: () {
                  onSizeChanged(size);
                },
                child: _containerBg(
                  Colors.white,
                  Text(
                    "$size",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
          else if (type == "blink")
            for (var blink in list)
              _buildGestureDetector(
                onTap: () {
                  onBlinkChanged(blink);
                },
                child: _containerBg(
                  Colors.white,
                  Text(
                    "$blink",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
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

  Widget _containerBg(Color color, Widget child) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
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
          _topContainerBg("글자 크기"),
          _baseContainer("size", textSize),
          _topContainerBg("글자 폰트"),
          _baseContainer("font", textFont),
          _topContainerBg("글자 속도"),
          _baseContainer("speed", textSpeed),
          _topContainerBg("글자 블링크"),
          _baseContainer("blink", textBlink),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
