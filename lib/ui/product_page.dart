import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../models/sneakers_model.dart';
import '../services/helper.dart';

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
                                onTap: () {},
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
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sneaker!.imageUrl.length,
                                    controller: pageController,
                                    onPageChanged: (page) {
                                      ProductNotifier.activePage = page;
                                    },
                                    itemBuilder: (context, int index) {
                                      Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.39,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.grey.shade300,
                                            child: CachedNetworkImage(
                                              imageUrl: sneaker.imageUrl[index],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                            right: 20,
                                            child: const Icon(
                                                Ionicons.heart_outline,
                                                color: Colors.grey),
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: Row(
                                                children: List<Widget>.generate(
                                                  sneaker.imageUrl.length,
                                                  (index) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4),
                                                    child: CircleAvatar(
                                                      radius: 5,
                                                      backgroundColor:
                                                          ProductNotifier
                                                                      .activepage !=
                                                                  index
                                                              ? Colors.grey
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }));
  }
}
