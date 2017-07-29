import 'dragon.dart';
import 'editor.dart';
import 'events.dart';

class Designer {
  static Editor editor;
  static int character = 0;
  static int characterIndex = 0;
  static int color = 0;
  static int colorBack = 1;
  static bool gridDisplayed = false;

  String get foreColor => Colors[color];

  String get backColor => Colors[colorBack];

  static init() {
    AppEvents.bus.subscribe(EventNames.ForeChange, setFore);
    AppEvents.bus.subscribe(EventNames.BackChange, setBack);
  }

  static void setFore(Function dataProvider) => color = dataProvider();

  static void setBack(Function dataProvider) => colorBack = dataProvider();
}
