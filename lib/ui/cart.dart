import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];

    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes'],
      };
    }).toList();

    cart = cartData.reversed.toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'My Cart',
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount: cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cart[index];
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 1,
                                    onPressed: doNothing,
                                    backgroundColor: const Color(0xFF000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade500,
                                      spreadRadius: 5,
                                      blurRadius: 0.3,
                                      offset: const Offset(0, 1),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: data['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                            left: 20,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                data['name'],
                                                style: appstyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  doNothing() {
    print('doing noting....');
  }
}
