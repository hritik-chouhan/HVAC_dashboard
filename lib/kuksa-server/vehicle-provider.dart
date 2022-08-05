import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/kuksa-server/vehicle-class.dart';

final vehicleProvider = StateNotifierProvider<VehicleSignal, vehicle>(
  (ref) => VehicleSignal(),
);

class VehicleSignal extends StateNotifier<vehicle> {
  static vehicle intial_value = vehicle(
    isAcActive: false,
    isAcDirectionDown: false,
    isAcDirectionMiddle: false,
    isAcDirectionUp: false,
    isFrontDefrosterActive: false,
    isRearDefrosterActive: false,
    isRecirculationActive: false,
  );
  VehicleSignal() : super(intial_value);

  void update({
    bool? isAcActive,
    bool? isAcDirectionDown,
    bool? isAcDirectionUp,
    bool? isAcDirectionMiddle,
    bool? isFrontDefrosterActive,
    bool? isRearDefrosterActive,
    bool? isRecirculationActive,
  }) {
    state = state.copywith(
      isAcActive: isAcActive,
      isAcDirectionDown: isAcDirectionDown,
      isAcDirectionMiddle: isAcDirectionMiddle,
      isAcDirectionUp: isAcDirectionUp,
      isFrontDefrosterActive: isFrontDefrosterActive,
      isRearDefrosterActive: isRearDefrosterActive,
      isRecirculationActive: isRecirculationActive,
    );
  }
}
