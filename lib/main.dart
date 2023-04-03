import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:postgres/postgres.dart';
import 'addQueuePage.dart';
import 'queuePage.dart';
import 'agentStatus.dart';
import 'dbhandler.dart';

void main() async {
 

final postgres = PostgresDatabase();
await postgres.connect();
final results = await postgres.executeQuery('select agent_name,agent_queue,agent_status,login_time,logout_time  from agent_logs where domainname=\'pbx.warmconnect.in\' order by agent_queue, agent_status');
await postgres.close();

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
