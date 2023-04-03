import 'package:flutter/material.dart';
import 'queueResourceUpdate.dart';

class QueuePageTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const List<String> list = <String>['hi', 'low', 'Three', 'Four'];
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Edit Test Queue'),
        QueueResourceUpdate(list),
      ],
    );
  }
}
