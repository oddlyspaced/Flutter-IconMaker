import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:projectminimal/theme.dart';

String iconAsset;

// create some values
// Color startingColor = Color(0xFFfbaf17);
// Color endingColor = Color(0xFFf27450);

Color startingColor = Colors.black;
Color endingColor = Colors.black;
Color foregroundColor = Colors.white;

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

double size = 0;

double direction = 0;

class EditorEditorScreen extends StatefulWidget {
  EditorEditorScreen(this.icon);

  final String icon;

  @override
  _EditorEditorScreenState createState() => _EditorEditorScreenState();
}

class _EditorEditorScreenState extends State<EditorEditorScreen> {
  @override
  Widget build(BuildContext context) {
    iconAsset = widget.icon;
    return EditorWidget();
  }
}

class EditorWidget extends StatefulWidget {
  @override
  _EditorWidgetState createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  final parentKey = new GlobalKey<ScaffoldState>();
  GlobalKey repaintKey = new GlobalKey();

  Future capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          repaintKey.currentContext.findRenderObject();
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
      parentKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Saved to Gallery successfully!",
            style: ThemeConstants.snackbar,
          ),
        ),
      );
    } catch (e) {
      parentKey.currentState.showSnackBar(
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
    return Scaffold(
      key: parentKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wall.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: RepaintBoundary(
                    key: repaintKey,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0 + direction, -1 + direction),
                                end: Alignment(0 - direction, 1 - direction),
                                stops: [0.25, 0.75],
                                colors: [startingColor, endingColor],
                              ),
                              //color: backgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                          ),
                          Padding(
                            padding: new EdgeInsets.all(100 - size),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: SvgPicture.asset(
                                iconAsset,
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
                flex: 3,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        left: 24,
                        right: 24,
                      ),
                      child: LinearColorEditor(
                        onBackgroundChanged: (color) {
                          startingColor = color;
                          endingColor = color;
                          setState(() {});
                        },
                        onForegroundChanged: (color) {
                          foregroundColor = color;
                          setState(() {});
                        },
                      ),
                    ),
                    Separator(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 8,
                      ),
                      child: GradientColorEditor(
                        onStartColorChanged: (color) {
                          startingColor = color;
                          setState(() {});
                        },
                        onEndColorChanged: (color) {
                          endingColor = color;
                          setState(() {});
                        },
                      ),
                    ),
                    Separator(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: SizeEditor(
                        onSizeChanged: (value) {
                          size = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Separator(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: AlignmentEditor(
                        onAlignmentChanged: (double value) {
                          direction = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Separator(),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  parentKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      "Saving...",
                      style: ThemeConstants.snackbar,
                    ),
                  ));
                  capturePng();
                },
                child: SaveButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 8,
      ),
      child: Container(
        height: 4,
        color: Colors.white70,
      ),
    );
  }
}

class LinearColorEditor extends StatelessWidget {
  LinearColorEditor({this.onBackgroundChanged, this.onForegroundChanged});

  final Function onBackgroundChanged;
  final Function onForegroundChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Color",
            style: ThemeConstants.title,
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
                            title: const Text('Select Background color'),
                            content: SingleChildScrollView(
                                child: ColorPickerBuilder(
                              pickerColor: pickerColor,
                              onColorChanged: onBackgroundChanged,
                            )),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
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
                          color: startingColor,
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
                            title: const Text('Select Foreground color'),
                            content: SingleChildScrollView(
                              child: ColorPickerBuilder(
                                pickerColor: pickerColor,
                                onColorChanged: onForegroundChanged,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
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
      ],
    );
  }
}

class GradientColorEditor extends StatelessWidget {
  GradientColorEditor({this.onStartColorChanged, this.onEndColorChanged});

  final Function onStartColorChanged;
  final Function onEndColorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Gradient Color",
            style: ThemeConstants.title,
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
                    "Starting : ",
                    style: ThemeConstants.subheading,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: const Text('Select Starting color'),
                            content: SingleChildScrollView(
                              child: ColorPickerBuilder(
                                pickerColor: pickerColor,
                                onColorChanged: onStartColorChanged,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
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
                          color: startingColor,
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
                    "Ending : ",
                    style: ThemeConstants.subheading,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: const Text('Select Ending color'),
                            content: SingleChildScrollView(
                              child: ColorPickerBuilder(
                                pickerColor: pickerColor,
                                onColorChanged: onEndColorChanged,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text(
                                  'Done',
                                  style: TextStyle(),
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
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
                          color: endingColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ColorPickerBuilder extends StatefulWidget {
  ColorPickerBuilder({this.pickerColor, this.onColorChanged});

  Color pickerColor;
  final Function onColorChanged;

  @override
  _ColorPickerBuilderState createState() => _ColorPickerBuilderState();
}

class _ColorPickerBuilderState extends State<ColorPickerBuilder> {
  
  String colorToHex(Color color) {
    String r = color.red.toRadixString(16);
    if (r.length == 1) {
      r = r + r;
    }
    String g = color.green.toRadixString(16);
    if (g.length == 1) {
      g = g + g;
    }
    String b = color.blue.toRadixString(16);
    if (b.length == 1) {
      b = b + b;
    }
    return r + g + b;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: (Color value) {
            print(colorToHex(value));
            widget.pickerColor = value;
            widget.onColorChanged(value);
            setState(() {
            });
          },
          showLabel: false,
          pickerAreaHeightPercent: 0.8,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          child: TextField(
            controller: TextEditingController(
              text: colorToHex(widget.pickerColor),
            ),
            onChanged: (text) {
              if (text.startsWith("#")) {
                text = text.substring(1);
              }
              if (text.length < 6) {
                return;
              }
              try {
                widget.pickerColor = Color(int.parse("0xFF" + text));
                widget.onColorChanged(widget.pickerColor);
                setState(() {});
              } catch (e) {}
            },
          ),
        ),
      ],
    );
  }
}

class SizeEditor extends StatelessWidget {
  SizeEditor({this.onSizeChanged});

  final Function onSizeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Size",
          style: ThemeConstants.title,
        ),
        Slider(
          activeColor: Colors.white,
          inactiveColor: Colors.white12,
          value: size,
          min: 0,
          max: 100,
          divisions: 50,
          onChanged: (value) {
            onSizeChanged(value);
          },
        ),
      ],
    );
  }
}

class AlignmentEditor extends StatelessWidget {
  AlignmentEditor({this.onAlignmentChanged});

  final Function onAlignmentChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Alignment",
          style: ThemeConstants.title,
        ),
        Slider(
          activeColor: Colors.white,
          inactiveColor: Colors.white12,
          value: direction.toDouble(),
          min: 0.0,
          max: 1.0,
          divisions: 100,
          onChanged: (value) {
            print(value);
            onAlignmentChanged(value);
          },
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
              // capturePng();
            },
            child: Text(
              "Save",
              textAlign: TextAlign.center,
              style: ThemeConstants.title,
            ),
          ),
        ),
      ),
    );
  }
}
