class VSPath {
  static const String vehicleSpeed = "Vehicle.Speed";
  static const String vehicleEngineRPM =
      "Vehicle.Powertrain.CombustionEngine.Engine.Speed";
  static const String vehicleFuelLevel = "Vehicle.Powertrain.FuelSystem.Level";
  static const String vehicleCoolantTemp =
      "Vehicle.Powertrain.CombustionEngine.Engine.ECT";
  static const String vehicleLeftIndicator =
      "Vehicle.Body.Lights.IsLeftIndicatorOn";
  static const String vehicleRightIndicator =
      "Vehicle.Body.Lights.IsRightIndicatorOn";
  //Selected Gear output=> 0=Neutral, 1/2/..=Forward, -1/..=Reverse, 126=Park, 127=Drive
  static const String vehicleSelectedGear =
      "Vehicle.Powertrain.Transmission.SelectedGear";
  static const String vehicleLowBeamOn = "Vehicle.Body.Lights.IsLowBeamOn";
  static const String vehicleHighBeamOn = "Vehicle.Body.Lights.IsHighBeamOn";
  static const String vehicleParkingLightOn = "Vehicle.Body.Lights.IsParkingOn";
  static const String vehicleHazardLightOn = "Vehicle.Body.Lights.IsHazardOn";
  static const String vehicleTravelledDistance = "Vehicle.TravelledDistance";
  static const String vehicleTrunkLocked = "Vehicle.Body.Trunk.IsLocked";
  static const String vehicleTrunkOpen = "Vehicle.Body.Trunk.IsOpen";
  // \"normal\",\"sport\",\"economy\",\"snow\",\"rain\"]
  static const String vehiclePerformanceMode =
      "Vehicle.Powertrain.Transmission.PerformanceMode";
  static const String vehicleAmbientAirTemperature =
      "Vehicle.AmbientAirTemperature";
  static const String vehicleMIL = "Vehicle.OBD.Status.MIL";
  static const String vehicleCruiseControlError =
      "Vehicle.ADAS.CruiseControl.Error";
  static const String vehicleCruiseControlSpeedSet =
      "Vehicle.ADAS.CruiseControl.SpeedSet";
  static const String vehicleCruiseControlSpeedisActive =
      "Vehicle.ADAS.CruiseControl.IsActive";
  static const String vehicleBatteryChargingStatus =
      "Vehicle.Powertrain.Battery.Charging.Status";
  static const String vehicleFrontLeftTier =
      "Vehicle.Chassis.Axle.Row1.Wheel.Left.Tire.Pressure";
  static const String vehicleFrontRightTier =
      "Vehicle.Chassis.Axle.Row1.Wheel.Right.Tire.Pressure";
  static const String vehicleRearLeftTier =
      "Vehicle.Chassis.Axle.Row2.Wheel.Left.Tire.Pressure";

  static const String vehicleRearRightTier =
      "Vehicle.Chassis.Axle.Row2.Wheel.Right.Tire.Pressure";
  static const String vehicleIsChildLockActiveLeft =
      "Vehicle.Cabin.Door.Row2.Left.IsChildLockActive";
  static const String vehicleIsChildLockActiveRight =
      "Vehicle.Cabin.Door.Row2.Right.IsChildLockActive";
  static const String vehicleCurrentLongitude =
      "Vehicle.CurrentLocation.Longitude";
  static const String vehicleCurrentLatitude =
      "Vehicle.CurrentLocation.Latitude";
  static const String vehicleFuelRate = "Vehicle.OBD.FuelRate";
  static const String vehicleInsideTemperature =
      "Vehicle.Cabin.HVAC.AmbientAirTemperature";
  static const String vehicleFrontLeftAc =
      "Vehicle.Cabin.HVAC.Station.Row1.Left.AirDistribution";
}
