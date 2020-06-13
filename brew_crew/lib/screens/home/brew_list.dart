import 'package:brewcrew/module/brew.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/screens/home/brew_tile.dart';

import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context)?? [];
    brews.forEach((brew) {
      print(brew.name);
      print(brew.strength);
      print(brew.sugars);
    });


    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew: brews[index]);

      },
    );
  }
}
