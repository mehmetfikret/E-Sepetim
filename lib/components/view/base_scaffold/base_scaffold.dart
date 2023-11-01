import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/bottom_bar/modern_bottom.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_ticaret/navbar.dart';

class BaseScaffold extends ConsumerWidget {
  const BaseScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

        ///////////////////////////////////

        drawer: SafeArea(child: NavbarMenu()),

        //////////////////////////////////

        appBar: AppBarWithSearchSwitch(
          backgroundColor: Constant.orange,
          onChanged: (text) {
             //update you provider here
            //searchText.value = text;
          }, //onSubmitted: (text) => searchText.value = text,
          appBarBuilder: (context) {
            return AppBar(
              backgroundColor: Constant.orange,
              elevation: 5,
              leading: IconButton(
                icon: const Icon(
                  Icons.person_rounded,
                  size: 34,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              centerTitle: true,
              title: Text(
                "E-Sepetim'e Hoş geldiniz",
                style: TextStyle(
                    fontStyle: FontStyle.values[0],
                    color: Constant.white,
                    fontSize: 17),
              ),
              actions: [ 
                AppBarSearchButton(
                  toolTipLastText: "Last input text",
                  toolTipStartText: "First input text",
                  searchIcon: Icons.search_outlined,
                  searchActiveButtonColor: Constant.orange,   
                ),
                
                // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
              ],
            );
          },
        ),
        body: Scaffold(       
          body: ModernBottomNavnar(),
        ));
  }
}
