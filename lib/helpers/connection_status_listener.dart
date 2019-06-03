import 'dart:io';
import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectionStatusListener {
  static final ConnectionStatusListener _singleton = new ConnectionStatusListener._internal();
  final Connectivity _connectivity = Connectivity();
  StreamController connectionChangeController = new StreamController.broadcast();
  ConnectionStatusListener._internal();
  bool hasConnection = false;

  static ConnectionStatusListener getInstance() => _singleton;

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;
  void dispose() => connectionChangeController.close();
  void _connectionChange(ConnectivityResult result) => checkConnection();

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
    }
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }
}