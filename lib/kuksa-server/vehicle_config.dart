// SPDX-License-Identifier: Apache-2.0


import 'dart:io';
import 'package:flutter_hvac/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;



final sockConnectprovider = FutureProvider.family<WebSocket, HttpClient>(
    (ref, client) => connect(client,ref));



// load certificates and set context and returns http client
Future<HttpClient> initializeClient() async {


  SecurityContext ctx = SecurityContext.defaultContext;

  HttpClient client = HttpClient(context: ctx)
    ..findProxy = null
    ..badCertificateCallback = (cert, host, port) {
      return true;
    };
  return client;
}



Future<WebSocket> connect(HttpClient client, ref) async {
  final config = ref.read(ConfigStateprovider);
  WebSocket socket = await WebSocket.connect(
      "wss://${config.hostname}:${config.port}",
      customClient: client);
  return socket;
}

