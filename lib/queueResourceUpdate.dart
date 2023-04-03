import 'package:flutter/material.dart';



List<String> list = ['one','two','three'];
class QueueResourceUpdate extends StatelessWidget{

  QueueResourceUpdate(this.list);
  List<String> list;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(list);
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        
        children: [
          ElevatedButton(onPressed: (){}, child: Text('Details')),
          Row(
            children: [
              Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: 200,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Parameter Name',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: 200,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Parameter Value',
                ),
              ),
            ),
          ),
              
              ElevatedButton(onPressed: (){}, child: Text('Update')),
            ],
          ),
          Row(
            children: [
              DropdownButtonClass(list:list),
              ElevatedButton.icon(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.add_circle_outline_rounded ),
                  label: Text('Agent'),
                ),
            ],
          ),
          Row(
            children: [
              DropdownButtonClass(list:list),
              ElevatedButton.icon(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.remove_circle_outline_rounded ),
                  label: Text('Agent'),
                ),
            ],
          ),
          ElevatedButton(onPressed: (){}, child: Text('Delete Queue')),
    
        ],
      ),
    );
  }
}



class DropdownButtonClass extends StatefulWidget {
  const DropdownButtonClass({super.key, required this.list});
  final List<String> list;
  
  @override
  State<DropdownButtonClass> createState() => _DropdownButtonClassState();
}

class _DropdownButtonClassState extends State<DropdownButtonClass> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
