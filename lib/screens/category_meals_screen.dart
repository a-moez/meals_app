import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> meals;
  CategoryMealsScreen(this.meals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? categoryMeals;

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs["title"];
    final String? categoryId = routeArgs["id"];
    categoryMeals = widget.meals.where((meal) {
      return meal.categories!.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String id) {
    setState(() {
      categoryMeals!.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals![index].id,
            title: categoryMeals![index].title,
            imageUrl: categoryMeals![index].imageUrl,
            duration: categoryMeals![index].duration,
            complexity: categoryMeals![index].complexity,
            affordability: categoryMeals![index].affordability,
          );
        },
        itemCount: categoryMeals?.length,
      ),
    );
  }
}
