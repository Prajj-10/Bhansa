/*//this is for dynamic text field

class CookingStepsModel{
  //String? cooking_duration;
  List<String>? cooking_steps;

  CookingStepsModel({this.cooking_steps});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Directions'] = cooking_steps;
    //data['Duration'] = cooking_duration;

    return data;
  }
}*/

//Post Recipe Model

class CookingStepsModel{
  String? recipe_title, recipe_ingredients, cooking_duration, image_url;
  int? num_of_servings;
  List<String>? cooking_steps;

  CookingStepsModel({this.recipe_title, this.num_of_servings, this.recipe_ingredients, this.cooking_duration, this.image_url, this.cooking_steps});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Recipe Title'] = recipe_title;
    data['Number of Servings'] = num_of_servings;
    data['Ingredients'] = recipe_ingredients;
    data['Duration'] = cooking_duration;
    data['Directions'] = cooking_steps;
    data['Image'] = image_url;

    return data;
  }
}