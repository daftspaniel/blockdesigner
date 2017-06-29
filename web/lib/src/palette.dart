import 'dart:html';
import 'designer.dart';
import 'dragon.dart';
import 'events.dart';
import 'util/tablebuilder.dart';

class Palette {
  final TableBuilder palette = new TableBuilder(9, 1);
  final String changeEventName;
  int index;

  Palette(this.changeEventName, HtmlElement parent) {
    palette
      ..build(parent)
      ..applyAll(setColor)..applyAll(colorSelect);

    AppEvents.bus.subscribe(changeEventName, (Function dataprovider) {
      palette.clearText();
      palette.all[dataprovider()].text = 'X';
    });
  }

  void setColor(int x, int y, TableCellElement tc) {
    tc.style.backgroundColor = Colors[x];
    tc.style.width = "15px";
    tc.style.height = "20px";
    if (x == 0) {
      tc.style.color = 'white';
    }
  }

  void colorSelect(int x, int y, TableCellElement tc) {
    tc.onClick.listen((MouseEvent e) {
      index = x;
      palette.clearText();
      tc.text = "X";
      AppEvents.bus.post(changeEventName, () {
        return x;
      });
    });
  }

}