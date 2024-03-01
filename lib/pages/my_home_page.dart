import 'package:book_flutter_app/pages/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_flutter_app/res/app_colors.dart' as AppColors;
import 'dart:convert';

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

late List popularBooks;
late TabController _tabController;
late ScrollController _scrollController;
ReadData () async{
  await DefaultAssetBundle.of(context).loadString('../json/pop_books.json').then((s){
    setState(() {
      popularBooks = json.decode(s);
    });
  });
}

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
          child: SafeArea(
            child:Scaffold(
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageIcon(
                          AssetImage('../img/menu.png'),
                          size: 24, 
                          color: Colors.black,
                          ),
                          Row(children: [
                            Icon(Icons.search),
                            SizedBox(width: 10,),
                            Icon(Icons.notifications),
                          ],
                          ),
                          ],
                    ),
                  ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                  child:
                   Text(
                    'Popular Books',
                  style: TextStyle(fontSize: 30),
                  ),
                  ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 180,
                  child: Stack(
                  children: [
                   Positioned(
                    top: 0,
                    left: -20,
                    right: 0,

                  child: Container(
                  height: 180,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: popularBooks==null?0:popularBooks.length,
                    itemBuilder: (_, i){
                    return Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(image: AssetImage(popularBooks[i]["img"]),
                        fit: BoxFit.fill,
                        )
                      ),
                    );
                  }),
                ),
               )
              ]
              ),
                ),
                Expanded(child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll){

                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                         child: Container(
                          margin: const EdgeInsets.only(bottom: 20, left: 10),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right: 10),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             
                              boxShadow: [
                                BoxShadow(
                                   color: Colors.grey.withOpacity(0.2),
                                   blurRadius: 7,
                                   offset: Offset(0, 0),
                                ),
                              ]
                            ),
                            tabs: [
                              Apptabs(color: AppColors.menu1Color, text: 'New'),
                              Apptabs(color: AppColors.menu2Color, text: 'Popular'),
                              Apptabs(color: AppColors.menu3Color, text: 'Trending'),
                            ],
                          ),
                         )
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Works'),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Works'),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Works'),
                      ),
                    )
                  ],),
                ))
                ],
              ),
            ), 
          ),
    );
  }
}