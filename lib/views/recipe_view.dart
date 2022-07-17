import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late String finalUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalUrl = widget.postUrl;
    if (widget.postUrl.contains('http://')) {
      finalUrl = widget.postUrl.replaceAll("http://", "https://");
      print(finalUrl + "this is final url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cuisine Recipe App"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeView(
                            postUrl:
                                "https://maps.mapmyindia.com/place-restaurants-near-Vamanjoor,%20Mangaluru,%20Karnataka,%20575028?@zdata=MTIuOTEwMTU1Kzc0Ljg5NTgwOSsxNi42NzYxODg4MzM4MDk2MysxMi45MTMzMjAsNzQuODkwMjUyOzEyLjkwODY0OCw3NC45MDA1NjUrcmVzdGF1cmFudHMrZWwrLA==ed")));
              },
              icon: Icon(Icons.map_outlined),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Color(0xff14AA84),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      (Platform.isIOS ? 104 : 100),
                  width: MediaQuery.of(context).size.width,
                  child: WebView(
                    onPageFinished: (val) {
                      // print(val);
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: finalUrl,
                    onWebViewCreated: (WebViewController webViewController) {
                      setState(() {
                        _controller.complete(webViewController);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
