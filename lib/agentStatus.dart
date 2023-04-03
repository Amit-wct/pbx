import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';




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