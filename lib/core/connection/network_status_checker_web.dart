import 'dart:html' as html;

class NetworkStatusChecker {
  Future<bool> check() async {
    return html.window.navigator.onLine ?? false;
  }
}
