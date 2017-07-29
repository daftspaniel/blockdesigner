import 'package:minibus/minibus.dart';

class EventNames {
  static const String ForeChange = "ForeChange";
  static const String BackChange = "BackChange";
  static const String BlockChange = "BlockChange";
}

class AppEvents {
  static MiniBus bus = new MiniBus();
}

const List<int> blockKeys = const [
  81,
  87,
  69,
  82,
  84,
  89,
  85,
  73,
  79,
  80,
  65,
  83,
  68,
  70,
  71,
  72
];
