import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        print("Animation");
        offset = revealAnimation.value;
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //initState();
          print("Animation over");
          coverAnimationController.forward();
        }
      });

    coverAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
    );
    coverAnimation = Tween<double>(
      begin: 0,
      end: 1000,
    ).animate(coverAnimationController)
      ..addListener(() {
        print("Animation");
        size = coverAnimation.value;
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //initState();
          print("Animation over");
          setState(() {});
        }
      });
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