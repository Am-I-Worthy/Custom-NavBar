import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

List navBarItems = ["Home", "About", "Blog", "Programs", "Support", "Contact"];

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  PageController pagecontroller;
  AnimationController controller;
  int duration;
  Color color;
  double height = 0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    pagecontroller = PageController(initialPage: 0);
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: pagecontroller,
                children: navBarItems.map((e) {
                  return PageContainer(e);
                }).toList(),
              ),
            ),
            Positioned(
              right: 80,
              top: 50,
              child: Container(
                height: 360,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          height == 0 ? height = 300 : height = 0;
                          isPlaying = !isPlaying;
                          isPlaying
                              ? controller.forward()
                              : controller.reverse();
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        color: Colors.blue,
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              width: height == 300 ? 95 : 0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                height == 300 ? "Close" : "Menu",
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21.0),
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: AnimatedIcon(
                                progress: controller,
                                color: Colors.white,
                                icon: AnimatedIcons.menu_close,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 50.0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: height,
                          width: 200,
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              children: navBarItems.map((e) {
                                return CustomNavigationButton(
                                    text: e,
                                    fun: () {
                                      setState(() {
                                        pagecontroller.animateToPage(
                                            navBarItems.indexOf(e),
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeInOut);
                                      });
                                    });
                              }).toList(),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageContainer extends StatefulWidget {
  final String text;
  PageContainer(this.text);
  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          widget.text.toUpperCase(),
          style: GoogleFonts.roboto(
            fontSize: 150,
            fontWeight: FontWeight.w900,
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}

class CustomNavigationButton extends StatefulWidget {
  final String text;
  final Function fun;
  CustomNavigationButton({this.fun, this.text});
  @override
  _CustomNavigationButtonState createState() => _CustomNavigationButtonState();
}

class _CustomNavigationButtonState extends State<CustomNavigationButton> {
  int duration;
  Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.fun();
      },
      child: MouseRegion(
        onEnter: (val) {
          setState(() {
            duration = 100;
            color = Colors.blue;
          });
        },
        onExit: (val) {
          setState(() {
            duration = 1200;
            color = Colors.black;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: duration ?? 100),
          color: color ?? Colors.black,
          height: 50,
          width: 200,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    widget.text,
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 21.0),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
