import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnectedToInternet;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl({required this.internetConnection});

  @override
  Future<bool> get isConnectedToInternet async =>
      await internetConnection.hasInternetAccess;
}
