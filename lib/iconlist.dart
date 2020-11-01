import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Color backgroundColor = Color.fromARGB(255, 33, 33, 33);
Color textPrimaryColor = Colors.white;
int listItems = 31;
List<String> icons = List();

class IconScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Helvetica",
      ),
      home: IconList(),
    );
  }
}

class IconList extends StatefulWidget {
  @override
  _IconListState createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  Future _initImages() async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();
    loadIcons(imagePaths);
  }

  void loadIcons(List<String> ic) {
    setState(() {
      icons = ic;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (icons.length == 0) {
      _initImages();
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wall.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 24,
                ),
                child: Text(
                  "Icons",
                  style: TextStyle(
                    fontSize: 36,
                    color: textPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 24,
                ),
                child: Text(
                  "${icons.length} Available",
                  style: TextStyle(
                    fontSize: 18,
                    color: textPrimaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children:
                          List.generate(icons.length, (index) => index)
                              .map((e) {
                        // return Container(
                        //   height: width * 0.25,
                        //   width: width * 0.25,
                        //   child: Icon(Icons.ac_unit),
                        // );
                        print("Hello " + icons[e]);

                        return Container(
                          height: width * 0.25,
                          width: width * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: SvgPicture.asset(
                                  icons[e],
                                  //"assets/icons/command.svg",
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
