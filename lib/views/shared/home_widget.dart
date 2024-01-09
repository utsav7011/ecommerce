import 'package:ecommerce/views/shared/product_card.dart';
import 'package:flutter/material.dart';

import '../../models/sneakers_model.dart';
import 'appstyle.dart';
import 'new_shoes.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
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
                    return ProductCard(
                      price: '\$${shoe.price}',
                      category: shoe.category,
                      id: shoe.id,
                      name: shoe.name,
                      image: shoe.imageUrl[0],
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
                      Text(
                        'Show All',
                        style: appstyle(20, Colors.black, FontWeight.w400),
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
