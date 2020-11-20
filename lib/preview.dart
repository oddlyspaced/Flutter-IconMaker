import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectminimal/theme.dart';

class PreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    "Chrome",
    "Settings",
    "Twitter",
    "Files",
    "Maps",
    "Facebook",
    "Photos"
  ];

  final Map<String, String> icons = {
    "Chrome": "chrome",
    "Settings": "settings",
    "Twitter": "twitter",
    "Files": "folder",
    "Maps": "compass",
    "Facebook": "facebook",
    "Photos": "image",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        image: DecorationImage(
          image: AssetImage("assets/wall.jpeg"),
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
                color: ThemeConstants.iconBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SvgPicture.asset(
                  "assets/icons/$icon.svg",
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomRowWidget extends StatelessWidget {
  final List<String> bottomIcons = ["phone", "message", "chrome", "camera"];

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
            color: Colors.grey,
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
                    color: ThemeConstants.iconBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SvgPicture.asset(
                      "assets/icons/${bottomIcons[index]}.svg",
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
