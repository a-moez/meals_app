import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  final Function setFilters;
  final Map<String, bool> filters;
  FiltersScreen(this.setFilters, this.filters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitchListTile(
      String text, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(text),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: (x) => updateValue(x),
    );
  }

  @override
  initState() {
    isGlutenFree = widget.filters["isGlutenFree"] as bool;
    isVegan = widget.filters["isVegan"] as bool;
    isVegetarian = widget.filters["isVegetarian"] as bool;
    isLactoseFree = widget.filters["isLactoseFree"] as bool;
    super.initState();
  }

  bool isGlutenFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool isLactoseFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => widget.setFilters({
              "isGlutenFree": isGlutenFree,
              "isVegan": isVegan,
              "isVegetarian": isVegetarian,
              "isLactoseFree": isLactoseFree,
            }),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          buildSwitchListTile(
              "Gluten Free", "Only show Gluten free meals", isGlutenFree,
              (newValue) {
            setState(() {
              isGlutenFree = newValue;
            });
          }),
          buildSwitchListTile("Vegan", "Only show Vegan meals", isVegan,
              (newValue) {
            setState(() {
              isVegan = newValue;
            });
          }),
          buildSwitchListTile(
              "Vegetarian", "Only show Vegetarian meals", isVegetarian,
              (newValue) {
            setState(() {
              isVegetarian = newValue;
            });
          }),
          buildSwitchListTile(
              "Lactose Free", "Only show Lactose free meals", isLactoseFree,
              (newValue) {
            setState(() {
              isLactoseFree = newValue;
            });
          }),
        ],
      ),
    );
  }
}
