import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TextScreen extends StatefulWidget {
  final TextEditingController textEditingController;
  final Color color;
  final Color color_bg;
  final int fontSize;
  final int speed;
  final int blink;
  final String fontFamily;
  final double screenWidth;
  final String lottie_bg;

  const TextScreen({
    Key? key,
    required this.textEditingController,
    required this.color,
    required this.color_bg,
    required this.fontSize,
    required this.fontFamily,
    required this.screenWidth,
    required this.speed,
    required this.blink,
    required this.lottie_bg,
  }) : super(key: key);

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  bool _isVisible = true;

  Timer? _blinkTimer;

  @override
  void initState() {
    super.initState();
    _updateAnimationSpeed();
    _updateBlink();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _blinkTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TextScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.speed != oldWidget.speed) _updateAnimationSpeed();
    if (widget.blink != oldWidget.blink) _updateBlink();
  }

  void _updateBlink() {
    _blinkTimer?.cancel();
    if (widget.blink == 0) {
      _isVisible = true;
      setState(() {});
    } else {
      _blinkTimer =
          Timer.periodic(Duration(seconds: 5 % widget.blink), (timer) {
        if (mounted) {
          _isVisible = !_isVisible;
          setState(() {});
        }
      });
    }
  }

  void _updateAnimationSpeed() {
    _animationController?.dispose();

    if (widget.speed != 0) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 7 - widget.speed),
      );
      _animation =
          Tween<double>(begin: 1.0, end: -1.0).animate(_animationController!);
      _animationController!.repeat();
    } else {
      _animationController?.dispose();
      _animationController = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 200,
              color: widget.color_bg,
              child: widget.speed > 0
                  ? AnimatedBuilder(
                      animation: _animation!,
                      builder: (context, child) {
                        return Transform.translate(
                          offset:
                              Offset(_animation!.value * widget.screenWidth, 0),
                          child: Opacity(
                            opacity: _isVisible ? 1 : 0,
                            child: Text(
                              widget.textEditingController.text == ""
                                  ? "글씨를 적어주세요."
                                  : widget.textEditingController.text,
                              style: TextStyle(
                                color: widget.color,
                                fontSize: widget.fontSize.toDouble(),
                                fontFamily: widget.fontFamily,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Opacity(
                      opacity: _isVisible ? 1 : 0,
                      child: Text(
                        widget.textEditingController.text == ""
                            ? "글씨를 적어주세요."
                            : widget.textEditingController.text,
                        style: TextStyle(
                          color: widget.color,
                          fontSize: widget.fontSize.toDouble(),
                          fontFamily: widget.fontFamily,
                        ),
                      ),
                    )),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '글씨를 적어주세요.',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: widget.fontSize.toDouble(),
                fontFamily: widget.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
