import 'package:flutter/material.dart';
import 'queueResourceUpdate.dart';


class QueuePageSupport extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const List<String> list = <String>['One', 'Two', 'Three',];
    return Column(
      children: [
        Text('Edit Support Queue'),
        QueueResourceUpdate(list),
      ],
    );
  }
}