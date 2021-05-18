import 'dart:async';
import 'dart:io';

class ErrorHandler {
  /// Function to handle error messages from the server
  void handleError(dynamic e) {
    print(e);
    if (e is SocketException) {
      throw ("No internet connection");
    }
    if (e is TimeoutException) {
      throw ("Request timeout, try again");
    }
    if (e is FormatException) {
      throw ("Error occurred, please try again");
    }
    throw (e);
  }

}
