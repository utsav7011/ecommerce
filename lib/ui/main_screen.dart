import 'package:community_material_icon/community_material_icon.dart';
import 'package:ecommerce/controller/mainscreen_Provider.dart';
import 'package:ecommerce/ui/cartpage.dart';
import 'package:ecommerce/ui/homepage.dart';
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
    HomePage(),
    CartPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: PageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: BottomNav(),
        );
      },
    );
  }
}
