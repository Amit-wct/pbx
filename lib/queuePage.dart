import 'package:flutter/material.dart';
import 'queuePageSales.dart';
import 'queuePageSupport.dart';
import 'queuePageTest.dart';


class QueuePage extends StatefulWidget{

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {

  var selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

     Widget page;
    switch (selectedIndex) {
      case 0:
        page = QueuePageSales();
        break;
      case 1:
        page = QueuePageSupport();
        break;
      case 2:
        page = QueuePageTest();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        
        
        children: [
    
        
        Row(
          
          children: [
          TextButton(onPressed: (){
            setState(() {
              selectedIndex =0;
            });
          }, child: Text('Sales')),
          TextButton(onPressed: (){
            setState(() {
              selectedIndex =1;
            });
          }, child: Text('Support')),
          TextButton(
            onPressed: (){
            setState(() {
              selectedIndex =2;
            }
            );},
            child: Text('Test'),
            // style: ButtonStyle(foregroundColor:MaterialStateProperty.all<Color>(Colors.green)),
          ),
        ],),
          page,
    
      ],),
    );
  }
}


