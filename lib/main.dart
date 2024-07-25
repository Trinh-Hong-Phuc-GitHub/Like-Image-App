import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:like_image_app/provider/item_provider.dart';
import 'package:like_image_app/widget/body_swipe.dart';
import 'package:provider/provider.dart';

import 'modal/item_modal.dart';

void main(List<String> arg) {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

enum fillterOption { all, favorite }

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Favotite Images',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == fillterOption.all) {
                  isFavorite = false;
                } else {
                  isFavorite = true;
                }
              });
            },
            iconColor: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: fillterOption.all,
                child: Text('Show All'),
              ),
              PopupMenuItem(
                value: fillterOption.favorite,
                child: Text('Favorite'),
              ),
            ],
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Consumer<ItemProvider>(
            builder: (context, item, child) {
              return badges.Badge(
                badgeContent: Text(
                  item.countItemFavorite.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.yellow],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
          ),
        ),
      ),
      body: SwipeBody(isFavorite: isFavorite),
    );
  }
}
