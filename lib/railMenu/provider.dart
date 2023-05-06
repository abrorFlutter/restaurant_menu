import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:resturant_menu/unitils/constt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderLang extends ChangeNotifier{

  bool _isItemSelected = false;
  int _selectedItemIndex = 0;

  void setItemIndex(value) {
    _selectedItemIndex = value;
    notifyListeners();
  }

  int getItemIndex () {
    return _selectedItemIndex;
  }


  bool getItemSelected () {
    return _isItemSelected;
  }

  setFavorite(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constanta.Fav_Meal, value);
  }

  Future<int?> getFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(Constanta.Fav_Meal)) {
      return prefs.getInt(Constanta.Fav_Meal);
    }
    return null;
  }

  setFavList(List<int> indexes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String mealIndexes = jsonEncode(indexes);
    prefs.setStringList(Constanta.Fav_Meals, indexes.map((e) => e.toString()).toList());
  }

  Future<List<int>>getFavList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? str = prefs.getStringList(Constanta.Fav_Meals);
    if(str != null) {
      return str.map((e) => int.parse(e)).toList();
    }
    return List.empty();
  }

  void notifierMetod() {
    notifyListeners();
  }
}