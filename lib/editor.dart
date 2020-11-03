import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:projectminimal/theme.dart';
import 'dart:ui' as ui;

class EditorScreen extends StatefulWidget {
  EditorScreen({this.iconAsset});

  final String iconAsset;

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

double size = 0;

// create some values
Color backgroundColor = Colors.black;
Color foregroundColor = Colors.white;

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

class _EditorScreenState extends State<EditorScreen> {
  GlobalKey _globalKey = new GlobalKey();
  final key = new GlobalKey<ScaffoldState>();

  Future capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 10.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      Image.memory(pngBytes);
      final result = ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 100,
        name: "test",
      );
      print(result);
      key.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Saved to Gallery successfully!",
            style: ThemeConstants.snackbar,
          ),
        ),
      );
    } catch (e) {
      key.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Error in Saving to Gallery!",
            style: ThemeConstants.snackbar,
          ),
        ),
      );
      print("ERROR");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeConstants.appTheme,
      home: Scaffold(
        key: key,
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
                        child: RepaintBoundary(
                          key: _globalKey,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: new EdgeInsets.all(100 - size),
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: SvgPicture.asset(
                                    widget.iconAsset,
                                    color: foregroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                title: const Text(
                                                    'Select Background color'),
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    pickerColor: pickerColor,
                                                    onColorChanged: (value) {
                                                      setState(() {
                                                        backgroundColor = value;
                                                      });
                                                    },
                                                    showLabel: true,
                                                    pickerAreaHeightPercent:
                                                        0.8,
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: const Text('Done'),
                                                    onPressed: () {
                                                      setState(() =>
                                                          currentColor =
                                                              pickerColor);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              color: backgroundColor,
                                            ),
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
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                title: const Text(
                                                    'Select Foreground color'),
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    pickerColor: pickerColor,
                                                    onColorChanged: (value) {
                                                      setState(() {
                                                        foregroundColor = value;
                                                      });
                                                    },
                                                    showLabel: true,
                                                    pickerAreaHeightPercent:
                                                        0.8,
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: const Text('Done'),
                                                    onPressed: () {
                                                      setState(() =>
                                                          currentColor =
                                                              pickerColor);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              color: foregroundColor,
                                            ),
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
                            Spacer(),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  right: 32,
                                  top: 16,
                                  bottom: 16,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    capturePng();
                                  },
                                  child: Text(
                                    "Save",
                                    textAlign: TextAlign.center,
                                    style: ThemeConstants.title,
                                  ),
                                ),
                              ),
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
