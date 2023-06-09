import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_menu/ichkiPages/inMeal.dart';
import 'package:resturant_menu/ovqatClass.dart';
import 'package:resturant_menu/unitils/navigator_settings.dart';

import '../railMenu/provider.dart';

class ProductItem extends StatefulWidget {
  final MealClass mealClass;
  final int index;
  final bool isFavorite;

  const ProductItem(this.mealClass, this.index, {this.isFavorite = false, Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<ProviderLang>(context,listen: false);
    return Consumer<ProviderLang>(builder: (context,child,data) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0) ),
            elevation: 40,
            child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Color(widget.mealClass.color!)),
                width: 240,
                child:  Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 56),
                      Row(
                        children: [
                          Container(
                            height: 20,width: 2,
                            color: const Color(0xff00195C),
                          ),
                          const SizedBox(width: 4),
                          Text(widget.mealClass.country!,style: const TextStyle(color: Color(0xff00195C)),)
                        ],
                      ),
                      const SizedBox(height: 16,),
                      SizedBox(
                        height: 46,
                        child: Text(
                          widget.mealClass.name!,
                          style: const TextStyle(fontSize: 18,color: Color(0xff1E2022),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("cost".tr()),
                          Text(widget.mealClass.cost!.toString()),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/olovicon.png"),
                              SizedBox(width: 2),
                              Text(widget.mealClass.time!),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/olov2.png"),
                              SizedBox(width: 4,),
                              Text(widget.mealClass.count!.toString()),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: ()  {
                            if(widget.isFavorite){
                              removeFavorite(widget.index);
                            }else{
                              addFavorite();
                            }
                          },
                              icon: widget.isFavorite ? const Icon(Icons.favorite)
                                  :const Icon(Icons.favorite_border)),
                          Container(
                            width: 120,height: 50,
                            child: ElevatedButton(
                              style:  ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color(0xff175B8F),
                                  )),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).push(createRoute(InMeal(widget.index)));
                                });
                              },
                              child:  Text("more".tr()),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ),
          Positioned(
            top: -20,
            right: 40,
            height: 120,width: 120,
            child: Hero(
                tag: 'productImage',
                child: Image.asset(widget.mealClass.imageUrl!)),
          ),
        ],
      );
    });
  }

  void addFavorite() async{
    final langProvider = Provider.of<ProviderLang>(context,listen: false);
    List<int> favList = await langProvider.getFavList();
    var newList = List.of(favList);
    if(!newList.contains(widget.index)) {
      newList.add(widget.index);
    }
    langProvider.setFavList(newList);
  }

  void removeFavorite(index) async{
    final langProvider = Provider.of<ProviderLang>(context,listen: false);
    List<int> favList = await langProvider.getFavList();
    var newList = List.of(favList);
    newList.remove(index);
    langProvider.setFavList(newList);
  }

}
