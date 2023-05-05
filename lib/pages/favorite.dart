import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_menu/ovqatClass.dart';

import '../railMenu/provider.dart';
import '../widgets/productItem.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mainProvider = Provider.of<ProviderLang>(context,listen: false);

    return FutureBuilder(future: mainProvider.getFavList(),  builder: (BuildContext context,AsyncSnapshot snapshot) {
      if(!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }else{
        return GridView.builder(
            padding: EdgeInsets.only(top: 20,bottom: 16),
            itemCount: snapshot.data.length,
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 316,
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 40,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductItem(MealClass.mealsRU[snapshot.data[index]],index);
            }
        );
      }
    });
  }
}
