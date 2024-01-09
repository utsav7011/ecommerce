import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class StaggeredTileView extends StatefulWidget {
  const StaggeredTileView({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggeredTileView> createState() => _StaggeredTileViewState();
}

class _StaggeredTileViewState extends State<StaggeredTileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  Text(
                    widget.price,
                    style: appstyle(20, Colors.black, FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
