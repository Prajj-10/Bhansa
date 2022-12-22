import 'package:flutter/material.dart';
import '../../model/recipe_model.dart';


class SearchRecipe extends StatefulWidget {
  const SearchRecipe({Key? key}) : super(key: key);

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {

  //I'm now going to create a dummy list of movies
  //you can build your own list, I used the IMDB data so you can use the same.
  static List<RecipeModel> main_recipes_list =[
    RecipeModel("Chicken Biryani", "Chicken Biryani is a famous recipe of South Asian countries full of healthy ingredients", 9.0,
    "https://images.food52.com/7f0yncraWeYUJG_lLbH2ie1xd6g=/2016x1344/d815e816-4664-472e-990b-d880be41499f--chicken-biryani-recipe.jpg"),

    RecipeModel("Thakali Food", "Chicken Biryani is a famous recipe of South Asian countries full of healthy ingredients", 9.0,
        "https://static.toiimg.com/photo/82048030.cms"),

    RecipeModel("Chinese Food", "Chicken Biryani is a famous recipe of South Asian countries full of healthy ingredients", 8.5,
        "https://d4t7t8y8xqo0t.cloudfront.net/resized/750X436/eazytrendz%2F2950%2Ftrend20201005112101.jpg"),

    RecipeModel("Red Curry", "", 8.0,
    "https://iamaileen.com/wp-content/uploads/2019/06/gaeng-daeng-red-curry-thai-food-must-eat-thailand-dishes-cuisine.jpg"),

    RecipeModel("Chicken Tikka Masala", "", 9.2,
        "https://www.seriouseats.com/thmb/DbQHUK2yNCALBnZE-H1M2AKLkok=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-tikka-masala-for-the-grill-recipe-hero-2_1-cb493f49e30140efbffec162d5f2d1d7.JPG"),

    RecipeModel("Thai Fried Noodles", "recipe_short_desc", 8.7,
    "https://www.chefspencil.com/wp-content/uploads/Pad-Thai.jpg.webp"),

  ];


  void updateList(String value){
    //This is the function that will filter out list
    //We will be back to this list after a while
    //now let's write our search function
    setState(() {
      display_list = main_recipes_list.where((element) => element.recipe_title!.toLowerCase().contains(value..toLowerCase())).toList();

    });
  }

  //creating the list that we are going to display and fliter
  List<RecipeModel> display_list = List.from(main_recipes_list);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         resizeToAvoidBottomInset: false,
        //backgroundColor: Color(0xFF061624).withOpacity(1.0),
        body: Column(
          children: [
            SizedBox(height: 20,),
            Text("Search",
              style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight:FontWeight.bold,
              ),),

            SizedBox(height: 20,),

            TextField(
             onChanged: (value)=> updateList(value),
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                //fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "eg: Biryani",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.white,
              ),
            ),

            SizedBox(height: 20,),

            Expanded(
                child:
                display_list.length == 0 ?
                Center(child: Text("No result found", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),)
                :
                GridView.builder(
                  itemCount: display_list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context, index)
                {
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                          child: Image.network(display_list[index].recipe_poster_url!,
                            height: 120,
                            fit: BoxFit.cover,
                            width: double.infinity,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text(display_list[index].recipe_title!, style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,
                          ),
                          ),

                          Text("${display_list[index].rating}",
                                  style: TextStyle(color: Colors.amber),),

                        ],),),
                      ],
                    ),
                  );
                })

            ),
          ],
        )
      ),
    );
  }
}
