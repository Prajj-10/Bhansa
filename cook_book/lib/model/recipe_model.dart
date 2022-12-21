//here we will write the RecipeModel data model class

class RecipeModel
{
  String? recipe_title;
  String? recipe_poster_url;
  String? recipe_short_desc;
  double? rating;

  RecipeModel(this.recipe_title, this.recipe_short_desc, this.rating, this.recipe_poster_url);

}