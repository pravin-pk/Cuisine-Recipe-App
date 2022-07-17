import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cuisine_recipe/models/recipe_model.dart';
import 'package:cuisine_recipe/views/recipe_view.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';
import '../main.dart';
import '../splash.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipies = [];
  late String ingridients;
  bool _loading = false;
  bool _initial = true;
  String query = "";
  String _cuisineValue = 'Indian';
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff14AA84),
        title: const Text(
          "Cuisine Recipe App",
          style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Pangolin'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const SplashScreen())));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.exit_to_app_sharp),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: <Color>[
              //     Color.fromARGB(255, 255, 255, 255),
              //     Color.fromARGB(255, 0, 0, 0),
              //   ],
              // ),,
              ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                    stops: [
                  0.0,
                  0.9
                ],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: !kIsWeb
                      ? Platform.isIOS
                          ? 60
                          : 5
                      : 10,
                  horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    // children: <Widget>[
                    //   Text(
                    //     "Cuisine Recipe App",
                    //     style: TextStyle(
                    //         fontSize: 18,
                    //         color: Colors.white,
                    //         fontFamily: 'Overpass'),
                    //   ),
                    //   // Text(
                    //   //   "Recipes",
                    //   //   style: TextStyle(
                    //   //       fontSize: 18,
                    //   //       color: Colors.blue,
                    //   //       fontFamily: 'Overpass'),
                    //   // )
                    // ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "So What's in your mind?",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass'),
                  ),
                  Text(
                    "Just Enter Ingredients you have and I will show the best recipes for you",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'OverpassRegular'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Overpass'),
                            decoration: InputDecoration(
                              hintText: "Enter Ingridients",
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.7),
                                  fontFamily: 'Overpass'),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff14AA84)),
                              ),
                            ),
                            autofocus: false,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          value: _cuisineValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                            fontFamily: 'OverpassRegular',
                          ),
                          borderRadius: BorderRadius.circular(8),
                          underline: Container(
                            height: 1,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _cuisineValue = newValue!;
                            });
                          },
                          items: <String>[
                            'American',
                            'Asian',
                            'British',
                            'Caribbean',
                            'Central europe',
                            'Chinese',
                            'Eastern europe',
                            'French',
                            'Greek',
                            'Indian',
                            'Italian',
                            'Japanese',
                            'Korean',
                            'Kosher',
                            'Mediterranean',
                            'Mexican',
                            'Middle eastern',
                            'Nordic',
                            'South americal',
                            'South east asian',
                            'World'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                            tooltip: "Search Button",
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            onPressed: () async {
                              if (textEditingController.text.isNotEmpty) {
                                setState(() {
                                  _loading = true;
                                });
                                print("doing it");
                                FocusScope.of(context).unfocus();
                                recipies = [];
                                Uri url = Uri.parse(
                                    "https://api.edamam.com/search?q=${textEditingController.text}&cuisineType=${_cuisineValue}&to=20&app_id=75693c9d&app_key=61ec3bda17a4e3bae6cdebd828a98103");
                                var response = await http.get(url);
                                // print(" $response this is response");
                                Map<String, dynamic> jsonData =
                                    jsonDecode(response.body);
                                // print("this is json Data $jsonData");
                                jsonData["hits"].forEach((element) {
                                  // print(element.toString());
                                  // RecipeModel recipeModel = RecipeModel(
                                  //   image: '',
                                  //   label: '',
                                  //   source: '',
                                  //   url: '',
                                  // );
                                  RecipeModel recipeModel =
                                      RecipeModel.fromMap(element['recipe']);
                                  recipies.add(recipeModel);
                                  // print(recipeModel.url);
                                });
                                setState(() {
                                  _loading = false;
                                  _initial = false;
                                });
                              } else {
                                print("not doing it");
                                showDialog(
                                    barrierColor: Color.fromARGB(98, 0, 0, 0),
                                    context: context,
                                    builder: (_) => NetworkGiffyDialog(
                                          image: Image.asset(
                                            'assets/images/eat.gif',
                                            fit: BoxFit.cover,
                                          ),
                                          entryAnimation:
                                              EntryAnimation.BOTTOM_RIGHT,
                                          title: Text(
                                            'Everything tastes good when you are on Diet 🍩🍕🥤',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Pangolin",
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          description: Text(
                                            "I Hope you aren't following any diet\n So chose the Best cuisine you like\n\n\n Ps: always say yes to more cheese",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Pangolin"),
                                          ),
                                          onlyOkButton: true,
                                          buttonOkColor: Color(0xff14AA84),
                                          onOkButtonPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xff14AA84)),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.search,
                                      size: 18, color: Colors.white),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    child: (!_initial)
                        ? GridView(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisSpacing: 20.0,
                                    maxCrossAxisExtent: 200.0),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            children: List.generate(recipies.length, (index) {
                              // print(recipies[index].dietLabels);
                              return GridTile(
                                  child: RecipieTile(
                                title: recipies[index].label,
                                imgUrl: recipies[index].image,
                                desc: recipies[index].source,
                                url: recipies[index].url,
                                dietLabels: recipies[index]
                                    .dietLabels
                                    .substring(1,
                                        recipies[index].dietLabels.length - 1),
                                ingredientLines: recipies[index]
                                    .ingredientLines
                                    .substring(
                                        1,
                                        recipies[index].ingredientLines.length -
                                            1),
                              ));
                            }),
                          )
                        : SizedBox(
                            // height: 600,
                            // width: 600,
                            child: Center(
                              child: Lottie.asset('assets/chef.json'),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url, dietLabels, ingredientLines;

  RecipieTile(
      {required this.title,
      required this.desc,
      required this.imgUrl,
      required this.url,
      required this.dietLabels,
      required this.ingredientLines});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                            postUrl: widget.url,
                          )));
            }
          },
          onLongPress: () {
            Vibration.vibrate(duration: 200, amplitude: 20);
            showDialog(
                barrierColor: Color.fromARGB(98, 0, 0, 0),
                context: context,
                builder: (_) => NetworkGiffyDialog(
                      image: Image.network(
                        widget.imgUrl,
                        height: 100,
                        width: 100,
                      ),
                      entryAnimation: EntryAnimation.BOTTOM,
                      title: Text(
                        'Ingredients Required',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Pangolin",
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      description: Text(
                        widget.ingredientLines,
                        style: TextStyle(
                            fontFamily: "Pangolin",
                            fontSize: 16,
                            fontWeight: FontWeight.w200),
                      ),
                      onlyOkButton: true,
                      buttonOkColor: Color(0xff14AA84),
                      onOkButtonPressed: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                      },
                    ));
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCard extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {required this.topColor,
      required this.bottomColor,
      required this.topColorCode,
      required this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 180,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          topColorCode,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          bottomColorCode,
                          style: TextStyle(fontSize: 16, color: bottomColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
