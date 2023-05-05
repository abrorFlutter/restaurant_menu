import 'package:flutter/material.dart';
import 'package:resturant_menu/ovqatClass.dart';
import 'package:resturant_menu/pages/meal.dart';
import 'package:resturant_menu/widgets/productItem.dart';

class Salads extends StatelessWidget {
  const Salads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Salads"),
            ProductItem(MealClass.mealsUZ[0], 0),
          ],
        ),
      ),
    );
  }
}