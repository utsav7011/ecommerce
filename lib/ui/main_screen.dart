import 'package:ecommerce/controller/mainscreen_Provider.dart';
import 'package:ecommerce/ui/cartpage.dart';
import 'package:ecommerce/ui/favourites.dart';
import 'package:ecommerce/ui/homepage.dart';
import 'package:ecommerce/ui/product_by_cart.dart';
import 'package:ecommerce/ui/profile.dart';
import 'package:ecommerce/ui/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/shared/bottomnav.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> PageList = [
    HomePage(),
    SearchPage(),
    FavouritesPage(),
    CartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: Color(0xFFE2E2E2),
          body: PageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}
