import 'package:ecommerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/top_image.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 8, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Atheletic Shoes',
                      style: appstyleWithHeight(
                        40,
                        Colors.white,
                        FontWeight.bold,
                        1.5,
                      ),
                    ),
                    Text(
                      'Collection',
                      style: appstyleWithHeight(
                        38,
                        Colors.white,
                        FontWeight.bold,
                        1.5,
                      ),
                    ),
                    TabBar(
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
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.265),
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.405,
                        color: Colors.amber,
                        child: Column(
                          children: [
                            Text(
                              'Latest Shoes',
                              style:
                                  appstyle(24, Colors.black, FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.405,
                        color: Colors.green,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.405,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
