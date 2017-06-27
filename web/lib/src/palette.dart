import 'dart:html';
import 'designer.dart';
import 'dragon.dart';
import 'util/tablebuilder.dart';

class Palette {
  final TableBuilder palette = new TableBuilder(9, 1);

  Palette(HtmlElement parent) {
    palette
      ..build(parent)
      ..applyAll(setColor)..applyAll(colorSelect);
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
      Designer.color = x;
      palette.clearText();
      tc.text = "X";
    });
  }
}