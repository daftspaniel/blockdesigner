import 'dart:html';
import 'dragon.dart';

import 'tablebuilder.dart';
import 'designer.dart';

class Editor {

  final HtmlElement parent = querySelector('#output');
  final TableBuilder palette = new TableBuilder(9, 1);
  final TableBuilder editorGrid = new TableBuilder(32, 16);

  final ButtonElement clearScreenButton = new ButtonElement();
  final ButtonElement hideGridButton = new ButtonElement();

  void build() {
    clearScreenButton.text = "CLS";
    hideGridButton.text = "GRID";
    clearScreenButton.onClick.listen((MouseEvent e) =>
        clearScreen(Designer.colorBack));
    hideGridButton.onClick.listen((MouseEvent e) =>
        toggleGrid());
    buildPalette();
    parent.append(new BRElement());
    parent.append(clearScreenButton);
    parent.append(hideGridButton);
    parent.append(new BRElement());
    buildMainGrid();
  }

  void buildPalette() {
    palette
      ..build(parent)
      ..applyAll(setColor)..applyAll(colorSelect);
  }

  void buildMainGrid() {
    editorGrid
      ..build(parent)
      ..applyAll(setTitle)..applyAll(clickHandler);
    clearScreen(Designer.colorBack);

    window.onKeyDown.listen((KeyboardEvent e) {
      if (e.keyCode > 48 && e.keyCode < 58) {
        Designer.color = e.keyCode - 49;
      }
    });
  }

  void clearScreen(int colorIndex) {
    editorGrid.all.forEach((TableCellElement tce) {
      tce.style.backgroundColor = Colors[colorIndex];
    });
  }

  void colorSelect(int x, int y, TableCellElement tc) {
    tc.onClick.listen((MouseEvent e) {
      Designer.color = x;
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
  }

  void setColor(int x, int y, TableCellElement tc) {
    tc.style.backgroundColor = Colors[x];
    tc.style.width = "15px";
    tc.style.height = "20px";
  }

  void toggleGrid() {
    if (Designer.gridDisplayed) {
      editorGrid.setCellSpacing(0);
    } else {
      editorGrid.setCellSpacing(1);
    }
    Designer.gridDisplayed = !Designer.gridDisplayed;
  }
}