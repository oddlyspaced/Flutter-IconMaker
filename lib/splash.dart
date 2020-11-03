import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:projectminimal/pager.dart';
import 'package:projectminimal/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeConstants.appTheme,
      home: Scaffold(
        body: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  Animation<double> revealAnimation;
  AnimationController revealAnimationController;

  Animation<double> coverAnimation;
  AnimationController coverAnimationController;

  double offset = 0;
  final double offsetMax = 28;

  double size = 0;

  List<String> imagePaths;

  Future _initImages() async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    imagePaths = manifestMap.keys
        .where((String key) => key.contains('icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();
    // start animation after the files have been loaded
    coverAnimationController.forward();
  }

  @override
  void initState() {
    super.initState();
    revealAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    revealAnimation = Tween<double>(
      begin: 0,
      end: offsetMax,
    ).animate(revealAnimationController)
      ..addListener(() {
        offset = revealAnimation.value;
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _initImages();
          //coverAnimationController.forward();
        }
      });

    coverAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    coverAnimation = Tween<double>(
      begin: 0,
      end: 1000,
    ).animate(coverAnimationController)
      ..addListener(() {
        size = coverAnimation.value;
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //initState();
          print("Animation over");
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: PagerScreen(imagePaths),
            ),
          );
        }
      });

    revealAnimationController.forward();
  }

  @override
  void dispose() {
    revealAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(
              0,
              offset,
            ),
            child: Container(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
              0,
              -offset,
            ),
            child: InkWell(
              onTap: () {
                revealAnimationController.forward();
              },
              child: Container(
                color: Colors.black,
                child: Text(
                  "P R J K T\nM N I M L",
                  style: ThemeConstants.title,
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: size,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF222222),
              ),
              height: 1,
              width: 1,
            ),
          ),
        ],
      ),
    );
  }
}
