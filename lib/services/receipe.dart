import 'dart:convert';
import 'package:cuisine_recipe/models/hits.dart';
import 'package:http/http.dart' as http;

class Recipie {
  List<Hits> hits = [];

  Future<void> getReceipe() async {
    Uri url = Uri.parse(
        "https://api.edamam.com/search?q=banana&app_id=75693c9d&app_key=61ec3bda17a4e3bae6cdebd828a98103");
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      Hits hits = Hits(
        recipeModel: element['recipe'],
      );
      // hits.recipeModel = add(Hits.fromMap(hits.recipeModel));
    });
  }
}
