import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_menu/ichkiPages/inMeal.dart';
import 'package:resturant_menu/ovqatClass.dart';
import 'package:resturant_menu/railMenu/provider.dart';
import 'package:resturant_menu/widgets/productItem.dart';

class Meal extends StatefulWidget {
    Meal({Key? key}) : super(key: key);

  @override
  State<Meal> createState() => _MealState();
}

class _MealState extends State<Meal> {


  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderLang>(builder: (context,data,child) {
      return SafeArea(
        child: Scaffold(
          body: LayoutBuilder(builder: (BuildContext context,BoxConstraints constraints) {
            return mainUI(constraints);
          }),
        ),
      );
    });
  }

  Widget mainUI(BoxConstraints constraints) {

    var axiscount = 1;
    var currentSize = constraints.maxWidth;

    if(currentSize <= 500) {
      axiscount = 1;
    }else if(currentSize > 500 && currentSize <= 750) {
      axiscount = 2;
    }else if(currentSize > 750 && currentSize <= 1000) {
      axiscount = 3;
    }else {
      axiscount = 4;
    }

    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 20,bottom: 16),
                itemCount: getMeals().length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 316,
                  crossAxisCount: axiscount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 40,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: getFavorites(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData) {
                        if(snapshot.data.contains(index)) {
                          return ProductItem(getMeals()[index],index,isFavorite: true);
                        }else{
                          return ProductItem(getMeals()[index],index,isFavorite: false);
                        }
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }

                  });
                }
            ),
          ),
        ],
      ),
    );
  }


  List<MealClass> getMeals() {
    switch (context.locale.toString()) {
      case 'uz_UZ': {
        return MealClass.mealsUZ;
      }
      case 'ru_RU': {
        return MealClass.mealsRU;
      }
      case 'en_US': {
        return MealClass.mealsEN;
      }
      default: return MealClass.mealsUZ;
    }
  }
  Future<List<int>> getFavorites() async {
    final langProvider = Provider.of<ProviderLang>(context,listen: false);
    return await langProvider.getFavList();

  }
}
