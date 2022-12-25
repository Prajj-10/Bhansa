//this is for dynamic text field

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
}