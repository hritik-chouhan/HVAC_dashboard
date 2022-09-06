import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'kuksa-server/intial_connection.dart';
import 'kuksa-server/vehicle_config.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient client = await initializeClient();
  print('hello');

  runApp(
    ProviderScope(
      child: MaterialApp(
        home: InitialScreen(client: client),
      ),
    ),
  );
}
