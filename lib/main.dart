import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ledwrite/show_screen.dart';
import 'package:ledwrite/text_option_screen.dart';
import 'package:ledwrite/text_screen.dart';

import 'color_option_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LedWrite(),
    );
  }
}

class LedWrite extends StatefulWidget {
  const LedWrite({super.key});

  @override
  State<LedWrite> createState() => _LedWriteState();
}

class _LedWriteState extends State<LedWrite> {
  TextEditingController _textEditingController = TextEditingController();

  int _selectedIndex = 0;

  Color _color = Colors.white;

  Color _color_bg = Colors.black;

  String _lottieBg = 'null';

  int _size = 20;
  int _speed = 0;
  int _blink = 0;
  String _font = 'NanumGothic';

  final List<Color> _colors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  final List<Color> _colors_bg = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  final List<int> _textSize = [20, 40, 50, 60, 70, 90];

  final List<int> _textSpeed = [0, 1, 2, 3, 4, 5];

  final List<String> _textFont = [
    'santokki',
    'silverstar',
    'handwrite',
    'hakgyo',
    'skybori',
    'taebaek',
  ];

  final List<int> _textBlink = [0, 1, 2, 3, 4, 5];

  final List<String> _lottiesBg = [
    // 'assets/lottie/cherryblossom.json',
  ];

  final List<String> _lottie_img = [
    // "cherryblossom.png"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _showScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowScreen(
          text: _textEditingController.text,
          color: _color,
          color_bg: _color_bg,
          fontSize: _size,
          fontFamily: _font,
          speed: _speed,
          blink: _blink,
          screenWidth: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Widget> _pages = [
      TextOptionScreen(
        onSizeChanged: (size) {
          setState(() {
            _size = size;
          });
        },
        onFontChanged: (font) {
          setState(() {
            _font = font;
          });
        },
        onSpeedChanged: (speed) {
          setState(() {
            _speed = speed;
          });
        },
        onBlinkChanged: (blink) {
          setState(() {
            _blink = blink;
          });
        },
        textSize: _textSize,
        textFont: _textFont,
        textSpeed: _textSpeed,
        textBlink: _textBlink,
      ),
      ColorOptionScreen(
        onColorChanged: (color) {
          setState(() {
            _color = color;
          });
        },
        colors: _colors,
        onColorBgChanged: (color_bg) {
          setState(() {
            _color_bg = color_bg;
          });
        },
        colors_bg: _colors_bg,
        onLottieBgChanged: (lottie_bg) {
          setState(() {
            _lottieBg = lottie_bg;
          });
        },
        lottie_bg: _lottie_img,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF060042),
      body: Column(
        children: [
          TextScreen(
              textEditingController: _textEditingController,
              color: _color,
              color_bg: _color_bg,
              fontSize: _size,
              fontFamily: _font,
              speed: _speed,
              blink: _blink,
              lottie_bg: _lottieBg,
              screenWidth: screenWidth),
          GestureDetector(
            onTap: () {
              _showScreen();
            },
            child: SizedBox(
              width: double.infinity,
              height: 80,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      Text(
                        '시작하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ]
                  ),
                )
              ),
            ),
          ),
          _pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields, size: 30),
            label: '글씨 효과',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens, size : 30),
            label: '색상 효과',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
