import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/kuksa-server/vehicle_config.dart';

import 'on_boarding_page.dart';

class InitialScreen extends ConsumerWidget {
  InitialScreen({Key? key, required this.client}) : super(key: key);
  final HttpClient client;
  late WebSocket socket;

  @override
  Widget build(BuildContext context, ref) {
    print('intial screen');
    final sockConnect = ref.watch(sockConnectprovider(client));
    print('is2');

    return sockConnect.when(
      data: (socket) {
        print('data');
        this.socket = socket;
        this.socket.pingInterval = const Duration(seconds: 2);
        return OnBoardingPage(client: client, socket: this.socket);
      },
      error: (e, stk) {
        print(e);
        ref.refresh(sockConnectprovider(client));
        return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
              child: Text(
            'error',
            style: TextStyle(color: Colors.white),
          )),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Text('loading', style: TextStyle(color: Colors.white))),
      ),
    );
  }
}
