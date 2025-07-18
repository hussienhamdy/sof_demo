import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}
