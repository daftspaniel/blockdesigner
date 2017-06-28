import 'dart:html';
import 'dragon.dart';
import 'toolbar.dart';
import 'util/tablebuilder.dart';
import 'designer.dart';

class Editor {

  final TableBuilder editorGrid = new TableBuilder(32, 16);
  final DivElement screenBorder = new DivElement();
  final Toolbar toolbar = new Toolbar();

  void build(HtmlElement parent) {
    buildScreenBorder();

    buildMainGrid(screenBorder);
    toolbar.build(parent, clearScreen, toggleGrid);

    parent..append(new BRElement())..append(
        new BRElement())..append(screenBorder);
  }

  void buildScreenBorder() {
    screenBorder
      ..style.backgroundColor = 'black'
      ..style.borderRadius = '6px'
      ..style.padding = '40px'
      ..style.paddingTop = '60px'
      ..style.paddingBottom = '60px'
      ..style.width = '550px';
  }

  void buildMainGrid(DivElement parent) {
    editorGrid
      ..build(parent)
      ..applyAll(setTile)..applyAll(clickHandler);
    clearScreen(Designer.colorBack);
    editorGrid.setCellSpacing(0);

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

  void clickHandler(int x, int y, TableCellElement tc) {
    tc.onClick.listen((MouseEvent e) {
      tc.style.backgroundColor = Colors[Designer.color];
    });
  }

  void setTile(int x, int y, TableCellElement tc) {
    tc.title = "@${x+y*32} [$x $y]";
    tc.style.width = "15px";
    tc.style.height = "20px";
  }

  void toggleGrid() {
    editorGrid.setCellSpacing(Designer.gridDisplayed ? 0 : 1);
    Designer.gridDisplayed = !Designer.gridDisplayed;
  }
}