// SPDX-License-Identifier: Apache-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';

final LeftSlider = StateNotifierProvider<leftclimate, int>(
  (ref) => leftclimate(),
);

class leftclimate extends StateNotifier<int> {
  leftclimate() : super(0);

  Future<void> update(value) async {
    state = value;
  }
}

final RightSlider = StateNotifierProvider<Rightclimate, int>(
  (ref) => Rightclimate(),
);

class Rightclimate extends StateNotifier<int> {
  Rightclimate() : super(0);

  Future<void> update(value) async {
    state = value;
  }
}

final fanSpeedProvider =
    StateNotifierProvider<fanslider, int>((ref) => fanslider());

class fanslider extends StateNotifier<int> {
  fanslider() : super(30);
  void update(value) {
    state = value;
  }
}
