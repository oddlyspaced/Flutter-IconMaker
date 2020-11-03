import 'package:flutter/material.dart';
import 'package:projectminimal/text_anim.dart';
import 'package:projectminimal/theme.dart';

class PagerScreen extends StatefulWidget {
  PagerScreen(this.imagePaths);

  final List<String> imagePaths;

  @override
  _PagerScreenState createState() => _PagerScreenState();
}

class _PagerScreenState extends State<PagerScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConstants.appTheme,
      home: Scaffold(
        body: PagerWidget(widget.imagePaths),
      ),
    );
  }
}

class PagerWidget extends StatefulWidget {
  PagerWidget(this.imagePaths);

  final List<String> imagePaths;

  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<PagerWidget> {
  int index = 0;
  List<String> titles = ["ICONS", "TEMPLATES", "WALLPAPERS"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "P R J K T\nM N I M L",
                style: ThemeConstants.title,
              ),
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
                      ),
                      child: ListPreview(),
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
    );
  }
}
