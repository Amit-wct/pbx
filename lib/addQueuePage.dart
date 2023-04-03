import 'package:flutter/material.dart';



class AddQueuePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SizedBox(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
        ),
        ElevatedButton.icon(
                onPressed: () {
                  
                },
                icon: Icon(Icons.add_circle_outline_rounded ),
                label: Text('Add'),
              ),
      ],
    );
  }
}