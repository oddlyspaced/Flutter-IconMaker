import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectminimal/theme.dart';

String iconColor;
String boxColor;
String textColor;
String imagePath;

class PreviewScreen extends StatelessWidget {
  PreviewScreen(
      this._iconColor, this._boxColor, this._textColor, this._imagePath);

  final String _iconColor;
  final String _boxColor;
  final String _textColor;
  final String _imagePath;

  @override
  Widget build(BuildContext context) {
    iconColor = _iconColor;
    boxColor = _boxColor;
    textColor = _textColor;
    imagePath = _imagePath;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
        );
      },
      theme: ThemeConstants.appTheme,
      home: Scaffold(
        body: PreviewWidget(),
      ),
    );
  }
}

class PreviewWidget extends StatelessWidget {
  final List<String> iconNames = [
    "App Store",
    "Apple TV",
    "Books",
    "Calendar",
    "Clock",
    "Contacts",
    "Health",
    "iCloud",
    "Gmail",
    "Music",
    "Photos",
    "Settings",
    "Stocks",
    "Wave",
    "Zoom"
  ];

  final Map<String, String> icons = {
    "App Store": "new_app_store",
    "Apple TV": "new_apple_tv",
    "Books": "new_books",
    "Calendar": "new_calendar",
    "Clock": "new_clock",
    "Contacts": "new_contacts",
    "Health": "new_health",
    "iCloud": "new_icloud",
    "Gmail": "new_mail",
    "Music": "new_music",
    "Photos": "new_photos",
    "Settings": "new_settings",
    "Stocks": "new_stocks",
    "Wave": "new_wave",
    "Zoom": "new_zoom",
  };

  @override
  Widget build(BuildContext context) {
    iconNames.shuffle();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        image: DecorationImage(
          image: (imagePath == null || imagePath.length == 0)
              ? AssetImage("assets/wall.jpeg")
              : FileImage(File(imagePath)),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              childAspectRatio: 0.76,
              padding: EdgeInsets.all(10),
              children: List.generate(iconNames.length, (index) {
                return IconWidget(icons[iconNames[index]], iconNames[index]);
              }),
            ),
            Spacer(),
            BottomRowWidget(),
          ],
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  IconWidget(this.icon, this.title);

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(int.parse("0xFF" + boxColor)),
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: SvgPicture.asset(
                  "assets/icons/$icon.svg",
                  color: Color(int.parse("0xFF" + iconColor)),
                  //"assets/icons/command.svg",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 4,
            ),
            child: Text(
              title,
              style: ThemeConstants.subheading.copyWith(
                fontSize: 14,
                color: Color(
                  int.parse("0xFF" + textColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomRowWidget extends StatelessWidget {
  final List<String> bottomIcons = [
    "new_phone",
    "new_messaging",
    "new_safari",
    "new_camera"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(64),
            borderRadius: BorderRadius.all(
              Radius.circular(
                32,
              ),
            ),
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 1,
            padding: EdgeInsets.all(5),
            children: List.generate(bottomIcons.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(int.parse("0xFF" + boxColor)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0), // 18 by default
                    child: SvgPicture.asset(
                      "assets/icons/${bottomIcons[index]}.svg",
                      color: Color(int.parse("0xFF" + iconColor)),
                      //"assets/icons/command.svg",
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
