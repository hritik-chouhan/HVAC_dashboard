import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class VehicleSignalConfig {
  static String authTokenPath = "cert/all_read_write.json.token";
  static String hostname = "localhost";
  static int port = 8090;
  static String uri = "ws://${hostname}:${port}";
  static String s_uri = "wss://${hostname}:${port}";
  static String authToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJrdWtzYS52YWwiLCJpc3MiOiJFY2xpcHNlIEtVS1NBIERldiIsImFkbWluIjp0cnVlLCJtb2RpZnlUcmVlIjp0cnVlLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MTc2NzIyNTU5OSwia3Vrc2EtdnNzIjp7IioiOiJydyJ9fQ.p2cnFGH16QoQ14l6ljPVKggFXZKmD-vrw8G6Vs6DvAokjsUG8FHh-F53cMsE-GDjyZH_1_CrlDCnbGlqjsFbgAylqA7IAJWp9_N6dL5p8DHZTwlZ4IV8L1CtCALs7XVqvcQKHCCzB63Y8PgVDCAqpQSRb79JPVD4pZwkBKpOknfEY5y9wfbswZiRKdgz7o61_oFnd-yywpse-23HD6v0htThVF1SuGL1PuvGJ8p334nt9bpkZO3gaTh1xVD_uJMwHzbuBCF33_f-I5QMZO6bVooXqGfe1zvl3nDrPEjq1aPulvtP8RgREYEqE6b2hB8jouTiC_WpE3qrdMw9sfWGFbm04qC-2Zjoa1yYSXoxmYd0SnliSYHAad9aXoEmFENezQV-of7sc-NX1-2nAXRAEhaqh0IRuJwB4_sG7SvQmnanwkz-sBYxKqkoFpOsZ6hblgPDOPYY2NAsZlYkjvAL2mpiInrsmY_GzGsfwPeAx31iozImX75rao8rm-XucAmCIkRlpBz6MYKCjQgyRz3UtZCJ2DYF4lKqTjphEAgclbYZ7KiCuTn9HualwtEmVzHHFneHMKl7KnRQk-9wjgiyQ5nlsVpCCblg6JKr9of4utuPO3cBvbjhB4_ueQ40cpWVOICcOLS7_w0i3pCq1ZKDEMrYDJfz87r2sU9kw1zeFQk";
}

final sockConnectprovider = FutureProvider.family<WebSocket, HttpClient>(
    (ref, client) => connect(client));

Future connectWebSoket() async {
  HttpClient client = await initializeClient();
  WebSocket socket = await connect(client);
  return [client, socket];
}

// load certificates and set context and returns http client
Future<HttpClient> initializeClient() async {
  // ByteData dataCA = await rootBundle.load('assets/cert/CA.pem');
  // ByteData dataCert = await rootBundle.load('assets/cert/Client.pem');
  // ByteData dataKey = await rootBundle.load('assets/cert/Client.key');
  // ByteData dataServ = await rootBundle.load('assets/cert/Server.pem');

  SecurityContext ctx = SecurityContext.defaultContext;
  // ctx.useCertificateChainBytes(dataCert.buffer.asUint8List());
  // ctx.usePrivateKeyBytes(dataKey.buffer.asUint8List());
  // ctx.setTrustedCertificatesBytes(dataCA.buffer.asUint8List());
  // ctx.setClientAuthoritiesBytes(dataCA.buffer.asUint8List());
  HttpClient client = HttpClient(context: ctx)
    ..findProxy = null
    ..badCertificateCallback = (cert, host, port) {
      return true;
    };
  return client;
}

// user VehicleSignalConfig.s_uri for secure websocket inplace of uri
// returns WebSocket after connection
Future<WebSocket> connect(HttpClient client) async {
  print(VehicleSignalConfig.s_uri);
  WebSocket socket =
      await WebSocket.connect(VehicleSignalConfig.s_uri, customClient: client);
  print('done');
  return socket;
}
