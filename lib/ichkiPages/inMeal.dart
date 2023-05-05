import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_menu/ovqatClass.dart';
import 'package:resturant_menu/railMenu/provider.dart';
import 'package:easy_localization/easy_localization.dart';



class InMeal extends StatefulWidget {
  final int selectedIndex;
  InMeal(this.selectedIndex, {Key? key}) : super(key: key);

  @override
  State<InMeal> createState() => _InMealState();
}

class _InMealState extends State<InMeal> {
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<ProviderLang>(context,listen: false);
    return Consumer<ProviderLang>(builder: (context,data,child) {
      return Container(
        height: double.infinity,
        decoration: const BoxDecoration(color: Color(0xff3875A3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {
              setState(() {
                langProvider.isItemSelected(false);
              });
            },
                icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
            Expanded(child: metod(getMeals(context)[widget.selectedIndex])),
          ],
        )
      );
    });
  }

  List<MealClass> getMeals(BuildContext context) {
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

  Widget metod(MealClass mealClass) {
    return Container(
      margin: const EdgeInsets.only(top: 90,right: 50),
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
           Padding(
             padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                  children: [
                    Container(width: 2,height: 16,color: const Color(0xff1153FC),),
                    SizedBox(width: 8,),
                    Text(mealClass.country.toString(),style: TextStyle(color: Color(0xff1153FC)),),
                  ],
                ),
                 SizedBox(height: 16,),
                 SizedBox(
                     child: Text(mealClass.name.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700)),
                 ),
                 SizedBox(height: 14,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       children: [
                         Image.asset("assets/images/olovicon.png"),
                         SizedBox(width: 2),
                         Text(mealClass.time!),
                       ],
                     ),
                     Row(
                       children: [
                         Image.asset("assets/images/olov2.png"),
                         SizedBox(width: 4,),
                         Text(mealClass.count!.toString()),
                       ],
                     )
                   ],
                 ),
                 SizedBox(height: 14,),
                 SizedBox(
                   child: Text(mealClass.mealAbout.toString() ,style: TextStyle(),),
                 )
               ],
             ),
           ),
          Positioned(
            top: -90,
            right: -40,
            height: 220,width: 220,
            child: Image.asset(MealClass.mealsUZ[widget.selectedIndex].imageUrl!),
          ),
        ],
      ),
    );
  }
}
