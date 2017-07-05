import 'editor.dart';
import 'events.dart';

class Designer {
  static int color = 0;
  static int colorBack = 1;
  static bool gridDisplayed = false;

  static init() {
    AppEvents.bus.subscribe(EventNames.ForeChange, setFore);
    AppEvents.bus.subscribe(EventNames.BackChange, setBack);
  }

  static void setFore(Function dataProvider) {
    color = dataProvider();
  }

  static void setBack(Function dataProvider) {
    colorBack = dataProvider();
  }

  static Editor editor;
}