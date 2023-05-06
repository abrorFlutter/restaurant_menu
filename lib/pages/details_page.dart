import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_menu/pages/favorite.dart';
import 'package:resturant_menu/pages/meal.dart';
import 'package:resturant_menu/pages/salad.dart';
import 'package:resturant_menu/railMenu/provider.dart';

import '../ovqatClass.dart';
import 'languagePage.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

   int _selectedIndex = 0;

   List<Widget> _pages = [
     Favorite(),
    Meal(),
    Salads(),
    Salads(),
    Salads(),
  ];

    List<Languages> listLang = [
     Languages("uz", true),
     Languages("ru", false),
     Languages("en", false),
   ];
   int activeLangIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Row(
    children: [
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return navRailScroll(constraints,context);
          }),
          Expanded(
              child: Navigator(
                  onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => _pages[_selectedIndex]),
              )),
        ],
      )
    );
  }

  Widget navRailScroll(BoxConstraints constraints,BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: NavigationRail(
            minWidth: 52,
            onDestinationSelected: (int value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            groupAlignment: 0.5,
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: const TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.bold),
            backgroundColor: const Color(0xff2A5270),
            selectedIndex: _selectedIndex,
            leading: leadingMethod(),
            destinations: [
              const NavigationRailDestination(
                icon: SizedBox(),
                label: RotatedBox(quarterTurns: 0,
                  child: Icon(Icons.favorite_border,color: Colors.white,),
                ),
              ),
              NavigationRailDestination(
                icon: const SizedBox(),
                label: RotatedBox(quarterTurns: -1,
                  child: Text("meals".tr()),
                ),
              ),
              NavigationRailDestination(
                icon: SizedBox(),
                label: RotatedBox(quarterTurns: -1,
                  child: Text("salads".tr()),
                ),
              ),
              NavigationRailDestination(
                icon: SizedBox(),
                label: RotatedBox(quarterTurns: -1,
                  child: Text("drinks".tr()),
                ),
              ),
              NavigationRailDestination(
                icon: SizedBox(),
                label: RotatedBox(quarterTurns: -1,
                  child: Text("fast_food".tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget leadingMethod() {
    final providerLang = Provider.of<ProviderLang>(context, listen: false);
    return Column(
      children: [
        const SizedBox(height: 80),
        ToggleButtons(
          fillColor: Colors.transparent,
          borderColor: Colors.transparent,
          selectedBorderColor: Colors.transparent,
          selectedColor: Colors.transparent,
          splashColor: Colors.transparent,
          direction: Axis.vertical,
          isSelected: listLang.map((e) => e.active).toList(),
          children:  [
            language(listLang[0]),
            language(listLang[1]),
            language(listLang[2]),
          ],
          onPressed: (int index) {
            setState(() {
              listLang.forEach((element) {element.active = false;});

              switch(index) {
                case 0:
                  {
                    context.setLocale(Locale("uz","UZ"));
                    providerLang.notifierMetod();
                  }
                  break;
                case 1:
                  {
                    context.setLocale(Locale("ru","RU"));
                    providerLang.notifierMetod();
                  }
                  break;
                case 2:
                  {
                    context.setLocale(Locale("en","US"));
                    providerLang.notifierMetod();
                  }
                  break;
              }
              listLang[index].active = true;
            });
          },
        ),
      ],
    );
  }

  Widget language( Languages lang) {
    return Container(
      width: 40,height: 40,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: lang.active? const Color(0xff206498): const Color(0xff2A5270),
      ),
      child: Center(
        child: Text(
          lang.name, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
