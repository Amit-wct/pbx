import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:postgres/postgres.dart';


const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
void main() async {

  final conn = PostgreSQLConnection(
  'mail005.ownmail.com',
  5434,
  'misc',
  username: 'domains',
  password: 'your_password',
  );


  await conn.open();
final results = await conn.query('select agent_name,agent_queue,agent_status,login_time,logout_time  from agent_logs where domainname=\'pbx.warmconnect.in\' order by agent_queue, agent_status');
  print(results);

  runApp(MyApp(results));
}

class MyApp extends StatelessWidget {

  final List result;
  MyApp(this.result);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: MyHomePage(title: 'Queue Resources',result:result),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  
}

class MyHomePage extends StatefulWidget {

  final List result;
  final String title;
  MyHomePage({Key? key, required this.title, required this.result}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  
  
  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AgentStatusPage(widget.result);
        break;
      case 1:
        page = QueuePage();
        break;
      case 2:
        page = AddQueuePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(
      builder: (context,constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.supervisor_account),
                      label: Text('Agent Status'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.stacked_bar_chart_rounded),
                      label: Text('Queue'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.format_list_bulleted_add),
                      label: Text('Add Queue'),
                    ),
                  ],
                  selectedIndex: selectedIndex, 
                  onDestinationSelected: (value) {
                      setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}


class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    

    IconData icon;
   

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Column(
      children: [
        Text("Queue"),
        Card(
            color: theme.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(20),
              // child: Text(pair.asLowerCase),
              child: Text(pair.asLowerCase,
              style: style,
              semanticsLabel: "${pair.first} ${pair.second}",),
            ),

            

          ),
      ],
    );
  }
}



class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    

    return ListView(
      children: [
        
      ],
    );
  }
}

class AgentStatusPage extends StatelessWidget{

  final List result;
  AgentStatusPage(this.result);
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    print(result);
    
    return Center(
      child: _createDataTable(result),
    );
  }
}

DataTable _createDataTable(List result) {
    
    // final PostgreSQLResult result;
    print(result);

    return DataTable(
      // columnSpacing:100,
      // border:TableBorder.all(color: Color.fromARGB(255, 110, 188, 252),width: 1,style: BorderStyle.solid,borderRadius: BorderRadius.circular(5)),
      
      columns: _createColumns(), rows: _createRows(result));
  }
 List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Name')),
      const DataColumn(label: Text('Queue')),
      const DataColumn(label: Text('Status')),
      const DataColumn(label: Text('Logged in')),
      const DataColumn(label: Text('Logged Out')),


    ];
  }
List<DataRow> _createRows(List result) {
  List<DataRow> rows = [];
  print(result);
  for (var i = 0; i < result.length; i++) {
    String name = result[i][0];
    String queue = result[i][1];
    String status = result[i][2];
    String loggin = result[i][3].toString();
    String loggout = result[i][4].toString();

    rows.add(
      DataRow(cells: [
        DataCell(Text(name)),
        DataCell(Text(queue)),
        DataCell(Text(status)),
        DataCell(Text(loggin)),
        DataCell(Text(loggout)),

      ]),
    );
  }

  return rows;
  }


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
