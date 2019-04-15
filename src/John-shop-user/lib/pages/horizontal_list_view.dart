
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalList extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/cats/snacks.png',
            image_caption: 'Snack',
          ),

          Category(
            image_location: 'images/cats/soda .png',
            image_caption: 'Drinks',
          ),

          Category(
            image_location: 'images/cats/sand.png',
            image_caption: 'Sandwich',
          ),

          Category(
            image_location: 'images/cats/food.png',
            image_caption: 'Food',
          ),
           Category(
            image_location: 'images/cats/food.png',
            image_caption: 'Other',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget{
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption,

  });
  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.all(2.0),
      child: InkWell(onTap: (){},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(image_location,
              width: 100.0,
              height: 80.0,),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  } 
}

