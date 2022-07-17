import 'package:cuisine_recipe/models/recipe_model.dart';

class Hits {
  RecipeModel recipeModel;

  Hits({required this.recipeModel});

  factory Hits.fromMap(
      Map<String, dynamic> parsedJson, Map<List, dynamic> parsedJsonList) {
    return Hits(recipeModel: RecipeModel.fromMap(parsedJson["recipe"]));
  }
}
