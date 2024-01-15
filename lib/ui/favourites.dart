import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/constants.dart';
import 'package:ecommerce/ui/main_screen.dart';
import 'package:ecommerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  // ignore: non_constant_identifier_names
  final _fav_box = Hive.box('fav_box');

  _deleteFav(int key) async {
    await _fav_box.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> fav = [];
    final favData = _fav_box.keys.map((key) {
      final item = _fav_box.get(key);
      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        "category": item['category'],
        "price": item['price'],
        "imageUrl": item['imageUrl'],
      };
    }).toList();

    fav = favData.reversed.toList();

    return Scaffold(
        // ignore: use_full_hex_values_for_flutter_colors
        backgroundColor: const Color(0xfe2e2e2e2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/top_image.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "My Favourites",
                    style: appstyle(40, Colors.white, FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: fav.length,
                  padding: const EdgeInsets.only(top: 100),
                  itemBuilder: (BuildContext context, index) {
                    final shoe = fav[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                spreadRadius: 5,
                                blurRadius: 0.3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: CachedNetworkImage(
                                      imageUrl: shoe['imageUrl'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shoe['name'],
                                          style: appstyle(16, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          shoe['category'],
                                          style: appstyle(
                                              14, Colors.grey, FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rs. ${shoe['price']}",
                                              style: appstyle(14, Colors.grey,
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    _deleteFav(shoe['key']);
                                    ids.removeWhere(
                                        (element) => element == shoe['id']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen()));
                                  },
                                  child: const Icon(
                                    Ionicons.heart_dislike,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
