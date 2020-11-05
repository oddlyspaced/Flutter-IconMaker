import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectminimal/editor.dart';
import 'package:projectminimal/theme.dart';

String iconAsset;

// create some values
Color backgroundColor = Colors.blue;
Color foregroundColor = Colors.white;

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

class EditorEditorScreen extends StatelessWidget {
  EditorEditorScreen(this.icon);

  final String icon;

  @override
  Widget build(BuildContext context) {
    iconAsset = icon;
    return EditorWidget();
  }
}

class EditorWidget extends StatefulWidget {
  @override
  _EditorWidgetState createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  @override
  Widget build(BuildContext context) {
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
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              colors: [Colors.red, Colors.yellow],
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
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ColorEditor(),
                    Separator(),
                    SizeEditor(),
                    Separator(),
                    Spacer(),
                    SaveButton(),
                  ],
                ),
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

class ColorEditor extends StatefulWidget {
  @override
  _ColorEditorState createState() => _ColorEditorState();
}

class _ColorEditorState extends State<ColorEditor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Color",
          style: ThemeConstants.title,
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
                              child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: (value) {
                                  setState(() {
                                    backgroundColor = value;
                                  });
                                },
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
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
                            title: const Text('Select Foreground color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: (value) {
                                  setState(() {
                                    foregroundColor = value;
                                  });
                                },
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
                                  Navigator.of(context).pop();
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

class SizeEditor extends StatefulWidget {
  @override
  _SizeEditorState createState() => _SizeEditorState();
}

class _SizeEditorState extends State<SizeEditor> {
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
            setState(() {
              size = value;
            });
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
