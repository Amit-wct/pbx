import 'queueResourceUpdate.dart';
import 'package:flutter/material.dart';


class QueuePageSales extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
   return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Edit Sales Queue'),
        QueueResourceUpdate(list),
      ],
    );
  }
}
