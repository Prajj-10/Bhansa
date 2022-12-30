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
  String? recipe_title, prepare_duration, cooking_duration, image_url, posted_date, testDurationFinal;
  String?  total_duration, p_duration, c_duration;
  int? num_of_servings;

  //Duration? prepare_duration, cooking_duration;


  List<String>? cooking_steps;
  List<String>? recipe_ingredients;

  CookingStepsModel({this.recipe_title, this.num_of_servings, this.recipe_ingredients, this.prepare_duration ,this.cooking_duration, this.image_url, this.cooking_steps, this.posted_date, this.total_duration, this.p_duration, this.c_duration, this.testDurationFinal});

  Map<String, dynamic> toJson_CookingDirections(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['Recipe Title'] = recipe_title;
    //data['Number of Servings'] = num_of_servings;
    //data['Ingredients'] = recipe_ingredients;
    //data['Prepare Duration'] = prepare_duration;
    //data['Cooking Duration'] = cooking_duration;
    //data['Directions'] = cooking_steps;
    //data['Image'] = image_url;
    data['Cooking Directions'] = cooking_steps;

    return data;
  }

  Map<String, dynamic> toJson_Ingredients(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['Recipe Title'] = recipe_title;
    //data['Number of Servings'] = num_of_servings;
    data['Ingredients'] = recipe_ingredients;
    //data['Prepare Duration'] = prepare_duration;
    //data['Cooking Duration'] = cooking_duration;
    //data['Directions'] = cooking_steps;
    //data['Image'] = image_url;

    return data;
  }
}