// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hvac/kuksa-server/intial_connection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';


class GetConfig extends ConsumerStatefulWidget {
  const GetConfig({Key? key, required this.client}) : super(key: key);
  final HttpClient client;

  @override
  ConsumerState<GetConfig> createState() => _GetConfigState();
}

class _GetConfigState extends ConsumerState<GetConfig> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final configStateProvider = ref.read(ConfigStateprovider.notifier);

      // String configFilePath = '/etc/xdg/AGL/nav_config.yaml';
      String configFilePath = '/Users/Smart/Desktop/test/nav_config.yaml';


      final configFile = File(configFilePath);
      configFile.readAsString().then((content) {
        final dynamic yamlMap = loadYaml(content);
        configStateProvider.update(
          hostname: yamlMap['hostname'],
          port: yamlMap['port'],
          kuksaAuthToken: yamlMap['kuskaAuthToken'],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(ConfigStateprovider);
    if (config.hostname == "" ||
        config.port == 0 ||
        config.kuksaAuthToken == ""
        ) {
      return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("ERROR",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                    "Something Wrong with config file! Check config.yaml file and restart"),
              ],
            )),
      );
    }
    return InitialScreen(client: widget.client);
  }
}

class Config {
  Config({
    required this.hostname,
    required this.port,
    required this.kuksaAuthToken,

  });
  final String hostname;
  final int port;
  final String kuksaAuthToken;

  Config copywith({
    String? hostname,
    int? port,
    String? kuksaAuthToken,
    String? mapboxAccessToken,
  }) =>
      Config(
        hostname: hostname ?? this.hostname,
        port: port ?? this.port,
        kuksaAuthToken: kuksaAuthToken ?? this.kuksaAuthToken,
      );
}

final ConfigStateprovider =
StateNotifierProvider<ConfigStateNotifier, Config>(
        (ref) => ConfigStateNotifier());

class ConfigStateNotifier extends StateNotifier<Config> {
  ConfigStateNotifier() : super(_initialValue);
  static final Config _initialValue = Config(
    hostname: "",
    port: 0,
    kuksaAuthToken: "",
  );
  void update({
    String? hostname,
    int? port,
    String? kuksaAuthToken,
  }) {
    state = state.copywith(
      hostname: hostname,
      port: port,
      kuksaAuthToken: kuksaAuthToken,
    );
  }
}
