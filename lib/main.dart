import 'dart:ui';

import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/filters_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> meals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void toggleFavorite(String id) {
    int favoriteIndex = favoriteMeals.indexWhere((meal) => meal.id == id);
    if (favoriteIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(favoriteIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
      });
    }
  }

  bool isFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  Map<String, bool> filters = {
    "isGlutenFree": false,
    "isVegan": false,
    "isVegetarian": false,
    "isLactoseFree": false,
  };

  void setFilters(Map<String, bool> newFilters) {
    setState(() {
      filters = newFilters;
      meals = DUMMY_MEALS.where((meal) {
        if (filters["isGlutenFree"] == true && meal.isGlutenFree != true) {
          return false;
        }
        if (filters["isVegan"] == true && meal.isVegan != true) {
          return false;
        }
        if (filters["isVegetarian"] == true && meal.isVegetarian != true) {
          return false;
        }
        if (filters["isLactoseFree"] == true && meal.isLactoseFree != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home:
      // TabsScreen(),
      routes: {
        //Default route
        "/": (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(meals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(isFavorite, toggleFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(setFilters, filters),
      },
      onGenerateRoute: (settings) {
        // if route not found
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        //last resort before presenting an error like 404
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     print(DUMMY_CATEGORIES);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Pharoh Meals"),
//       ),
//       body: CategoriesScreen(),
//     );
//   }
// }
