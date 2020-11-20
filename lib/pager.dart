import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projectminimal/iconlist.dart';
import 'package:projectminimal/preview.dart';
import 'package:projectminimal/text_anim.dart';
import 'package:projectminimal/theme.dart';

List<String> imagePaths;

class PagerScreen extends StatefulWidget {
  PagerScreen(this.imagePaths);

  final List<String> imagePaths;

  @override
  _PagerScreenState createState() => _PagerScreenState();
}

class _PagerScreenState extends State<PagerScreen> {
  Future<void> checkStoragePermission() async {
    print("Checking storage!");
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // We didn't ask for permission yet.
      print("Storage undetermined");

      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);
    }

    // You can can also directly ask the permission about its status.
    if (await Permission.storage.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      print("Storage Restricted");
    }
  }

  @override
  Widget build(BuildContext context) {
    imagePaths = widget.imagePaths;
    checkStoragePermission();
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
        body: PagerWidget(),
      ),
    );
  }
}

class PagerWidget extends StatefulWidget {
  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<PagerWidget> {
  int index = 0;
  List<String> titles = [
    "ICONS",
    "PREVIEW", /*, "TEMPLATES", "WALLPAPERS"*/
  ];
  List<Widget> previews = [
    IconListPreview(),
    PreviewItem(),
    // TemplatePreview(),
    // IconListPreview()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "P R J K T\nM N I M L",
                    style: ThemeConstants.title,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SvgPicture.asset(
                    "assets/icons/command.svg",
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Container(
              color: Colors.white70,
              height: 2,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 24,
              ),
              child: AnimatedEntryText(
                key: ValueKey(titles[index]),
                text: titles[index],
                duration: Duration(
                  seconds: 1,
                ),
                textStyle: ThemeConstants.heading,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: titles.length,
                  onPageChanged: (page) {
                    index = page;
                    setState(() {});
                  },
                  controller: PageController(
                    initialPage: 0,
                    viewportFraction: 0.90,
                  ),
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 24,
                      ),
                      child: previews[position],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconListPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => IconScreen(imagePaths)));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
              image: DecorationImage(
                image: AssetImage("assets/wall.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              children: List.generate(imagePaths.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                );
              }),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                8,
              ),
              child: Text(
                imagePaths.length.toString() + " icons",
                style: ThemeConstants.title.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TemplatePreview extends StatelessWidget {
  final List<TemplateItem> templates = [
    TemplateItem("Minimalist Black", Colors.black, Colors.white),
    TemplateItem("Minimalist White", Colors.white, Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
            image: DecorationImage(
              image: AssetImage("assets/wall.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: templates.length,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              templates[position].title,
                              style: ThemeConstants.subheading,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: templates[position].backgroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                height: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Container(
                                height: 16,
                                decoration: BoxDecoration(
                                  color: templates[position].foregroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              8,
            ),
            child: Text(
              templates.length.toString() + " templates",
              style: ThemeConstants.title.copyWith(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class TemplateItem {
  TemplateItem(this.title, this.backgroundColor, this.foregroundColor);

  final String title;
  final Color backgroundColor, foregroundColor;
}

class PreviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String iconColor = "FFFFFF";
    String boxColor = "000000";

    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Row(
            children: [
              Text("Icon Color : "),
              Flexible(
                child: TextField(
                  onChanged: (text) {
                    iconColor = text;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Box Color : "),
              Flexible(
                child: TextField(
                  onChanged: (text) {
                    boxColor = text;
                  },
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PreviewScreen(boxColor, iconColor),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class SamplePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
