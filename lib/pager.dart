import 'package:flutter/material.dart';
import 'package:projectminimal/iconlist.dart';
import 'package:projectminimal/text_anim.dart';
import 'package:projectminimal/theme.dart';

class PagerScreen extends StatefulWidget {
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
  List<String> titles = ["ICONS", "HAHA", "YES"];

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
              child: RotateAnimatedTextKit(
                text: "ICONS dope",
                pause: Duration(
                  milliseconds: 500,
                ),
                isRepeatingAnimation: true,
                duration: Duration(
                  milliseconds: 500,
                ),
                repeatForever: true,
                textStyle: ThemeConstants.heading,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: titles.length,
                  onPageChanged: (page) {
                    index = page;
                    setState(() {});
                  },
                  controller: PageController(
                    initialPage: 0,
                    viewportFraction: 0.9,
                  ),
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              (position % 2 == 0) ? Colors.green : Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                      ),
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
