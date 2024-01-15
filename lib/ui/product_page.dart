import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../models/sneakers_model.dart';
import '../services/helper.dart';
import '../views/shared/appstyle.dart';
import '../views/shared/checkout_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.id,
    required this.category,
  });

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  final _cartBox = Hive.box('cart_box');

  late Future<Sneakers> _sneaker;
  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSneakersById(widget.id);
    } else {
      _sneaker = Helper().getkidsSneakersById(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Sneakers>(
        future: _sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            Text("Error ${snapshot.error} ");
          }
          final sneaker = snapshot.data;
          return Consumer<ProductNotifier>(
            builder: (context, ProductNotifier, child) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leadingWidth: 0,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              ProductNotifier.shoesizes.clear();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Ionicons.ellipsis_horizontal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                    snap: false,
                    floating: true,
                    backgroundColor: Colors.transparent,
                    expandedHeight: MediaQuery.of(context).size.height,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: sneaker!.imageUrl.length,
                              controller: pageController,
                              onPageChanged: (page) {
                                ProductNotifier.activePage = page;
                              },
                              itemBuilder: (context, int index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.39,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.grey.shade300,
                                      child: CachedNetworkImage(
                                        imageUrl: sneaker.imageUrl[index],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          0.09,
                                      right: 20,
                                      child: const Icon(Ionicons.heart_outline,
                                          color: Colors.grey),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: Row(
                                        children: List<Widget>.generate(
                                          sneaker.imageUrl.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  ProductNotifier.activepage !=
                                                          index
                                                      ? Colors.grey
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.63,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sneaker.name,
                                        style: appstyle(
                                            40, Colors.black, FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            sneaker.category,
                                            style: appstyle(20, Colors.grey,
                                                FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          RatingBar.builder(
                                            minRating: 1,
                                            maxRating: 4,
                                            initialRating: 4,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 22,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 1),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rs. ${sneaker.price}",
                                            style: appstyle(26, Colors.black,
                                                FontWeight.w600),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Colors:",
                                                style: appstyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                radius: 7,
                                                backgroundColor: Colors.black,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                radius: 7,
                                                backgroundColor: Colors.red,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Select Size",
                                                style: appstyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "View Size Guide",
                                                style: appstyle(16, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: ListView.builder(
                                              itemCount: ProductNotifier
                                                  .shoesizes.length,
                                              scrollDirection: Axis.horizontal,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              itemBuilder: (context, index) {
                                                final sizes = ProductNotifier
                                                    .shoesizes[index];

                                                return ChoiceChip(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    side: const BorderSide(
                                                      color: Colors.black,
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  disabledColor: Colors.white,
                                                  label: Text(
                                                    ProductNotifier
                                                            .shoesizes[index]
                                                        ['size'],
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  selected: ProductNotifier
                                                          .shoesizes[index]
                                                      ['isSelected'],
                                                  onSelected: (newState) {
                                                    if (ProductNotifier.sizes
                                                        .contains(
                                                            sizes['size'])) {
                                                      ProductNotifier.sizes
                                                          .remove(
                                                              sizes['size']);
                                                    } else {
                                                      ProductNotifier.sizes
                                                          .add(sizes['size']);
                                                    }
                                                    print(
                                                        ProductNotifier.sizes);
                                                    ProductNotifier.toggleCheck(
                                                        index);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                80,
                                        child: Text(
                                          sneaker.title,
                                          style: appstyle(26, Colors.black,
                                              FontWeight.w600),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        sneaker.description,
                                        textAlign: TextAlign.justify,
                                        maxLines: 5,
                                        style: appstyle(
                                            14, Colors.grey, FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                          ),
                                          child: CheckoutButton(
                                            onTap: () async {
                                              _createCart(
                                                {
                                                  "id": sneaker.id,
                                                  "name": sneaker.name,
                                                  "category": sneaker.category,
                                                  "imageUrl":
                                                      sneaker.imageUrl[0],
                                                  "price": sneaker.price,
                                                  "qty": 1,
                                                },
                                              );
                                              ProductNotifier.sizes.clear();
                                              Navigator.pop(context);
                                            },
                                            label: "Add to cart ... ",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
