import 'dart:async';
import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/kuksa-server/vehicle_config.dart';
import 'package:untitled/kuksa-server/vehicle_methods.dart';

import '../HomePage.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({Key? key, required this.client, required this.socket})
      : super(key: key);
  final WebSocket socket;
  final HttpClient client;

  @override
  ConsumerState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  late Timer _timer;
  late WebSocket _socket;
  // static const int open = 1;
  // static const int closed = 3;

  @override
  void initState() {
    print('onboarding');
    super.initState();
    _socket = widget.socket;
    VISS.init(widget.socket);
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // print(widget.socket.readyState);
      if (widget.socket.readyState == 3) {
        ref.refresh(sockConnectprovider(widget.client));
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.socket.listen(
        (data) {
          // VISS.parseData(ref, data);
          // print(data);
        },
        onError: (e, stk) {
          print(e.toString());
          ref.refresh(sockConnectprovider(widget.client));
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    widget.socket.close(786887, "Connection lost with server!");
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      socket: _socket,
    );
  }
}
