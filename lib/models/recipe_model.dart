class RecipeModel {
  final String image;
  final String url;
  final String source;
  final String label;
  final String dietLabels;
  final String ingredientLines;

  RecipeModel(
      {required this.image,
      required this.url,
      required this.label,
      required this.source,
      required this.dietLabels,
      required this.ingredientLines});

  factory RecipeModel.fromMap(Map<String, dynamic> parsedJson) {
    return RecipeModel(
      image: parsedJson["image"],
      url: parsedJson["url"],
      source: parsedJson["source"],
      label: parsedJson["label"],
      dietLabels: parsedJson["dietLabels"].toString(),
      ingredientLines: parsedJson["ingredientLines"].toString(),
    );
  }
}
