import 'package:flutter/material.dart';

/**
 * Using Gradients, Fractional Offsets, Page Views and Other Widgets in Dart's Flutter Framework - https://youtu.be/vgcv4Fn9ERo
 */

void main() => runApp(MaterialApp(
      title: 'Gallery Demo',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: DisplayPage(),
    ));

class DisplayPage extends StatelessWidget {
  final List<String> images = [
    'assets/wallpaper1.jpeg',
    'assets/wallpaper2.jpeg',
    'assets/wallpaper3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
          child: SizedBox.fromSize(
        size: Size.fromHeight(550.0),
        child: PageView.builder(
          itemCount: images.length,
          controller: PageController(viewportFraction: 1.0),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(images[index], fit: BoxFit.cover),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                            Color(0x00000000).withOpacity(0.9),
                            Color(0xFFFFFFFF).withOpacity(0.01),
                          ])),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
