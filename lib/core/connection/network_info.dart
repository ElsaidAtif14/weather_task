import 'package:weather/core/connection/network_status_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final NetworkStatusChecker checker;

  NetworkInfoImpl({required this.checker});

  @override
  Future<bool> get isConnected => checker.check();
}
