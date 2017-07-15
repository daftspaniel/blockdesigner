import 'dart:html';
import '../designer.dart';
import '../dragon.dart';
import '../events.dart';
import '../util/tablebuilder.dart';

class CharPalette {
  final TableBuilder palette = new TableBuilder(16, 1);
  final String changeEventName;

  CharPalette(this.changeEventName, HtmlElement parent) {
    palette..build(parent);
    palette.all.forEach(setBackground);

    AppEvents.bus.subscribe(changeEventName, (Function dataProvider) {
      print(changeEventName);
      palette.all.forEach(setBackground);
    });
  }

  setBackground(TableCellElement tce) {
    tce.style
      ..backgroundColor = Colors[Designer.color]
      ..width = "20px"
      ..height = "30px";
  }
}
