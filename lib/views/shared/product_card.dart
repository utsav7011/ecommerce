import 'package:ecommerce/models/constants.dart';
import 'package:ecommerce/ui/favourites.dart';
import 'package:ecommerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';

class ProductCard extends StatefulWidget {
  ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _fav_box = Hive.box('fav_box');

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _fav_box.add(addFav);
    getFavourites();
  }

  getFavourites() {
    final favData = _fav_box.keys.map((key) {
      final item = _fav_box.get(key);
      return {
        "key": key,
        "id": "id",
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((item) => item['id']).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool selected = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.6,
              offset: Offset(1, 1),
            ),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image!),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: () async {
                          if (ids.contains(widget.id)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavouritesPage()));
                          } else {
                            _createFav({
                              "id": widget.id,
                              "name": widget.name,
                              "category": widget.category,
                              "price": widget.price,
                              "imageUrl": widget.image[0],
                            });
                          }
                        },
                        child: ids.contains(widget.id)
                            ? const Icon(Ionicons.heart)
                            : const Icon(Ionicons.heart_outline),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithHeight(
                          36, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style: appstyleWithHeight(
                          18, Colors.grey, FontWeight.bold, 1.5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appstyle(30, Colors.black, FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Text(
                            'Colors',
                            style: appstyle(18, Colors.grey, FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ChoiceChip(
                            label: const Text(''),
                            selected: selected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
