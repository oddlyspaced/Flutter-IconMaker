import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectminimal/text_anim.dart';
import 'package:projectminimal/theme.dart';

List<String> images;

class PagerScreen extends StatefulWidget {
  PagerScreen(this.imagePaths);

  final List<String> imagePaths;

  @override
  _PagerScreenState createState() => _PagerScreenState();
}

class _PagerScreenState extends State<PagerScreen> {
  @override
  Widget build(BuildContext context) {
    images = widget.imagePaths;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  List<String> titles = ["ICONS", "TEMPLATES", "WALLPAPERS"];
  List<Widget> previews = [ListPreview(), TemplatePreview(), ListPreview()];

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

class ListPreview extends StatelessWidget {
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
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            children: List.generate(images.length, (index) {
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
                      images[index],
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
              images.length.toString() + " icons",
              style: ThemeConstants.title.copyWith(color: Colors.black),
            ),
          ),
        ),
      ],
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
