import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectminimal/theme.dart';

class EditorScreen extends StatefulWidget {
  EditorScreen({this.iconAsset});

  final String iconAsset;

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

double size = 0;

class _EditorScreenState extends State<EditorScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeConstants.appTheme,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/wall.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Expanded(
              flex: 10,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: new EdgeInsets.all(size),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: SvgPicture.asset(
                                  widget.iconAsset,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Color",
                                style: ThemeConstants.title,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 4,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Background : ",
                                        style: ThemeConstants.subheading,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Foreground : ",
                                        style: ThemeConstants.subheading,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                              ),
                            ),
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                              ),
                            ),
                            Container(
                              child: Text(
                                "Size",
                                style: ThemeConstants.title,
                              ),
                            ),
                            Slider(
                              activeColor: Colors.white,
                              inactiveColor: Colors.white12,
                              value: size,
                              min: 0,
                              max: 100,
                              divisions: 50,
                              onChanged: (value) {
                                setState(() {
                                  size = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
