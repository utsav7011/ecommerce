import 'package:ecommerce/views/shared/category_btn.dart';
import 'package:ecommerce/views/shared/custom_spacer.dart';
import 'package:ecommerce/views/shared/staggered_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/sneakers_model.dart';
import '../services/helper.dart';
import '../views/shared/appstyle.dart';
import '../views/shared/product_card.dart';

class ProductByCart extends StatefulWidget {
  ProductByCart({
    super.key,
    required this.tabIndex,
  });

  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getkidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/top_image.png",
                    ),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            Icons.sort,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(
                        text: "Men's Shoes",
                      ),
                      Tab(
                        text: "Women's Shoes",
                      ),
                      Tab(
                        text: "Kid's Shoes",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FutureBuilder<List<Sneakers>>(
                      future: _male,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error} ");
                        } else {
                          final male = snapshot.data;
                          return Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: StaggeredGridView.countBuilder(
                                padding: EdgeInsets.zero,
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 16,
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.extent(
                                        (index % 2 == 0) ? 1 : 1,
                                        (index % 4 == 1 || index % 4 == 3)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.38
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35),
                                itemCount: male!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final shoe = snapshot.data![index];
                                  return StaggeredTileView(
                                    name: shoe.name,
                                    price: shoe.price.toString(),
                                    imageUrl: shoe.imageUrl[1].toString(),
                                  );
                                }),
                          );
                        }
                      },
                    ),
                    FutureBuilder<List<Sneakers>>(
                      future: _female,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error} ");
                        } else {
                          final male = snapshot.data;
                          return Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: StaggeredGridView.countBuilder(
                                padding: EdgeInsets.zero,
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 16,
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.extent(
                                        (index % 2 == 0) ? 1 : 1,
                                        (index % 4 == 1 || index % 4 == 3)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.38
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35),
                                itemCount: male!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final shoe = snapshot.data![index];
                                  return StaggeredTileView(
                                    name: shoe.name,
                                    price: shoe.price.toString(),
                                    imageUrl: shoe.imageUrl[1].toString(),
                                  );
                                }),
                          );
                        }
                      },
                    ),
                    FutureBuilder<List<Sneakers>>(
                      future: _kids,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error} ");
                        } else {
                          final male = snapshot.data;
                          return Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: StaggeredGridView.countBuilder(
                                padding: EdgeInsets.zero,
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 16,
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.extent(
                                        (index % 2 == 0) ? 1 : 1,
                                        (index % 4 == 1 || index % 4 == 3)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.38
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35),
                                itemCount: male!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final shoe = snapshot.data![index];
                                  return StaggeredTileView(
                                    name: shoe.name,
                                    price: shoe.price.toString(),
                                    imageUrl: shoe.imageUrl[1].toString(),
                                  );
                                }),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              // color: Colors.black38,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    const CustomSpacer(),
                    Text(
                      "Filter",
                      style: appstyle(40, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Text(
                      "Gender",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryBtn(
                          btnClr: Colors.black,
                          label: "Men",
                          onPress: () {},
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Women",
                          onPress: () {},
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Kids",
                          onPress: () {},
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Category",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryBtn(
                          btnClr: Colors.black,
                          label: "Shoes",
                          onPress: () {},
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Apparrels",
                          onPress: () {},
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Accessories",
                          onPress: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Price",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    Slider(
                        value: _value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: _value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value) {}),
                    const CustomSpacer(),
                    Text(
                      "Brands",
                      style: appstyle(
                        20,
                        Colors.black,
                        FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                        itemCount: brand.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Image.asset(
                                brand[index],
                                height: 60,
                                width: 80,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
