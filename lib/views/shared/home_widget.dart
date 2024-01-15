import 'package:ecommerce/controller/product_provider.dart';
import 'package:ecommerce/ui/product_by_cart.dart';
import 'package:ecommerce/ui/product_page.dart';
import 'package:ecommerce/views/shared/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/sneakers_model.dart';
import 'appstyle.dart';
import 'new_shoes.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                CircularProgressIndicator();
              } else if (snapshot.hasError) {
                Text("Error ${snapshot.error} ");
              }
              final male = snapshot.data;
              return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        productNotifier.shoeSizes = shoe.sizes;
                        // print(productNotifier.shoesizes);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                    id: shoe.id, category: shoe.category)));
                      },
                      child: ProductCard(
                        price: '\$${shoe.price}',
                        category: shoe.category,
                        id: shoe.id,
                        name: shoe.name,
                        image: shoe.imageUrl[0],
                      ),
                    );
                  });
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Shoes',
                    style: appstyle(24, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductByCart(
                                        tabIndex: tabIndex,
                                      )));
                        },
                        child: Text(
                          'Show All',
                          style: appstyle(20, Colors.black, FontWeight.w400),
                        ),
                      ),
                      const Icon(Icons.arrow_right),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: FutureBuilder<List<Sneakers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error} ");
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final shoe = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewShoes(imageUrl: shoe.imageUrl[0]),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
