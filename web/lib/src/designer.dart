import 'events.dart';

class Designer {
  static int color = 0;
  static int colorBack = 1;
  static bool gridDisplayed = false;

  static init() {
    AppEvents.bus.subscribe("BACK_CHANGE", setBack);
  }

  static setBack() {
    print("SETBACK");
    colorBack = 5;
  }
}