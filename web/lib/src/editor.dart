import 'dart:html';
import 'dragon.dart';

import 'tablebuilder.dart';
import 'designer.dart';

HtmlElement parent = querySelector('#output');

void buildEditor() {
  buildMainGrid();
  buildPalette();
}

void buildPalette() {
  TableBuilder tb = new TableBuilder(1, 9);
  tb.build(parent);
}

void buildMainGrid() {
  TableBuilder tb = new TableBuilder(32, 16);
  tb.build(parent);
  tb.applyAll(setTitle);
  tb.applyAll(clickHandler);

  window.onKeyDown.listen((KeyboardEvent e) {
    if (e.keyCode > 48 && e.keyCode < 58) {
      Designer.color = e.keyCode - 49;
    }
  });
}

void clickHandler(int x, int y, TableCellElement tc) {
  tc.onClick.listen((MouseEvent e) {
    tc.style.backgroundColor = Colors[Designer.color];
  });
}

void setTitle(int x, int y, TableCellElement tc) {
  tc.title = "$x $y";
  tc.style.width = "15px";
  tc.style.height = "20px";
  print("$x $y");
}