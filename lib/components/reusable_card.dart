import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {

  final Color color;
  final Widget cardChild;
  final Function tapFunction;
  final Function longPressFunction;

  ReusableCard(
      {@required this.color,
        this.cardChild,
        this.tapFunction,
        this.longPressFunction}
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapFunction,
      onLongPress: longPressFunction,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
