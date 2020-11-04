import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectminimal/editor.dart';
import 'package:projectminimal/theme.dart';

List<String> imagePaths = List();

class IconScreen extends StatelessWidget {
  IconScreen(this.icons);

  final List<String> icons;

  @override
  Widget build(BuildContext context) {
    imagePaths = icons;
    return MaterialApp(
      theme: ThemeConstants.appTheme,
      home: IconList(),
    );
  }
}

class IconList extends StatefulWidget {
  @override
  _IconListState createState() => _IconListState();
}

class _IconListState extends State<IconList> {
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
                    color: ThemeConstants.textPrimaryColor,
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
                  "${imagePaths.length} Available",
                  style: TextStyle(
                    fontSize: 18,
                    color: ThemeConstants.textPrimaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
              ),
              Expanded(
                child: Container(
                  child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 4,
                    children: List.generate(imagePaths.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditorScreen(imagePaths[index])));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeConstants.iconBackground,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: SvgPicture.asset(
                                imagePaths[index],
                                //"assets/icons/command.svg",
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
