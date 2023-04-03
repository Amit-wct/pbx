

import 'dart:async';
import 'package:postgres/postgres.dart';

class PostgresDatabase {
  static const String host = 'your-host';
  static const int port = 5432;
  static const String databaseName = 'your-database-name';
  static const String username = 'your-username';
  static const String password = 'your-password';

  late PostgreSQLConnection _connection;

  Future<void> connect() async {
    _connection = PostgreSQLConnection(
      'mail005.ownmail.com',
      5434,
      'misc',
      username: 'domains',
      password: 'your_password',
    );

    await _connection.open();
  }

 Future<List> executeQuery(String query,
      [List<dynamic>? values]) async {
    if (_connection == null) {
      await connect();
    }

    final substitutionValues = values != null
        ? Map.fromEntries(values.asMap().entries.map((entry) =>
            MapEntry('${entry.key + 1}', entry.value)))
        : null;

    final results =
        await _connection.query(query, substitutionValues: substitutionValues);

    return results.map((resultRow) => resultRow.asMap()).toList();
}



  Future<void> close() async {
    await _connection.close();
  }
}
