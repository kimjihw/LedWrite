import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowScreen extends StatefulWidget {
  final String text;
  final Color color;
  final Color color_bg;
  final int fontSize;
  final int speed;
  final int blink;
  final String fontFamily;
  final double screenWidth;

  const ShowScreen({
    super.key,
    required this.text,
    required this.color,
    required this.color_bg,
    required this.fontSize,
    required this.fontFamily,
    required this.speed,
    required this.blink,
    required this.screenWidth,
  });

  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  bool _isVisible = true;

  Timer? _blinkTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setLandscapeOrientation();
    if (widget.blink != 0) {
      _blinkTimer =
          Timer.periodic(Duration(seconds: 5 % widget.blink), (timer) {
        setState(() {
          _isVisible = !_isVisible;
        });
      });
    }
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
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController?.dispose();
    _blinkTimer?.cancel();
    super.dispose();
  }

  void _setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _setPortraitOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _setPortraitOrientation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _setPortraitOrientation();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: widget.color_bg,
            child: Center(
              child: widget.speed != 0 && _animation != null
                  ? AnimatedBuilder(
                      animation: _animation!,
                      builder: (context, child) {
                        return Transform.translate(
                          offset:
                              Offset(_animation!.value * widget.screenWidth, 0),
                          child: Opacity(
                            opacity: _isVisible ? 1.0 : 0.0,
                            child: Text(
                              widget.text == "" ? "글씨를 적어주세요." : widget.text,
                              style: TextStyle(
                                  color: widget.color,
                                  fontSize: widget.fontSize.toDouble(),
                                  fontFamily: widget.fontFamily),
                            ),
                          ),
                        );
                      })
                  : Opacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      child: Text(
                        widget.text == "" ? "글씨를 적어주세요." : widget.text,
                        style: TextStyle(
                          color: widget.color,
                          fontSize: widget.fontSize.toDouble(),
                          fontFamily: widget.fontFamily,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
