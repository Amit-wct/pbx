import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:postgres/postgres.dart';
import 'addQueuePage.dart';
import 'queuePage.dart'; 
import 'agentStatus.dart';
import 'dbhandler.dart';
import 'package:http/http.dart' as http;

void main() async {
 

final postgres = PostgresDatabase();
// await postgres.connect();
// final results = await postgres.executeQuery('select agent_name,agent_queue,agent_status,login_time,logout_time  from agent_logs where domainname=\'pbx.warmconnect.in\' order by agent_queue, agent_status');
// await postgres.close();

//   print(results);
 final results =  [];
//  final results =  [{0: 'alpesh', 1: 'sales', 2: 'logged in', 3: '2022-11-07 07:27:03.537018Z', 4: '2022-10-19 10:35:56.161211Z'}, {0: 'ankur', 1: 'sales', 2: 'logged in', 3: '2022-08-30 07:55:29.116986Z', 4: '2022-08-30 07:54:51.307257Z'}, {0: 'anamoy', 1: 'sales', 2: 'logged in', 3: '2022-07-25 11:03:05.940316Z', 4: '2022-07-24 17:01:00.878128Z'}, {0: 'vijeth', 1: 'support', 2: 'logged in', 3: '2023-05-18 05:02:04.454318Z', 4: '2023-05-17 12:52:41.380512Z'}, {0: 'sandeep', 1: 'support', 2: 'logged out', 3: '2023-05-17 12:59:58.117355Z', 4: '2023-05-17 15:13:28.079204Z'}, {0: 'sandeepc', 1: 'support', 2: 'logged out', 3: '2023-05-18 00:37:44.824772Z', 4: '2023-05-18 04:41:58.339045Z'}, {0: 'prathamesh', 1: 'support', 2: 'logged out', 3: '2023-05-17 13:43:28.169640Z', 4: '2023-05-17 23:15:55.297949Z'}];
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
