import 'dart:html';
import 'dragon.dart';
import 'events.dart';
import 'gui/toolbar.dart';
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

    parent..append(screenBorder);
  }

  void buildScreenBorder() {
    screenBorder
      ..style.position = 'absolute'
      ..style.top = '70px'
      ..style.left = '30px'
      ..style.backgroundColor = 'black'
      ..style.borderRadius = '6px'
      ..style.padding = '60px'
      ..style.paddingTop = '40px'
      ..style.paddingBottom = '40px'
      ..style.width = '460px';
  }

  void buildMainGrid(DivElement parent) {
    editorGrid
      ..build(parent)
      ..applyAll(setTile)
      ..applyAll(mouseEventsHandler);
    clearScreen(Designer.colorBack);
    editorGrid.setCellSpacing(0);

    window.onKeyDown.listen((KeyboardEvent e) {
      String event = e.ctrlKey ? EventNames.BackChange : EventNames.ForeChange;
      if (e.keyCode > 48 && e.keyCode < 58) {
        AppEvents.bus.post(event, () => e.keyCode - 49);
      } else if (blockKeys.contains(e.keyCode)) {
        AppEvents.bus
            .post(EventNames.BlockChange, () => blockKeys.indexOf(e.keyCode));
      }
    });
  }

  void clearScreen(int colorIndex) {
    editorGrid.all.forEach((TableCellElement tce) {
      tce.style.backgroundColor = Colors[colorIndex];
    });
  }

  void mouseEventsHandler(int x, int y, TableCellElement tc) {
    tc.onClick.listen((MouseEvent e) {
      setBlockValue(tc, Designer.color);
    });

    tc.onContextMenu.listen((MouseEvent e) {
      setBlockValue(tc, Designer.colorBack);
      e.preventDefault();
    });

    tc.onMouseEnter.listen((MouseEvent e) {
      int color = e.buttons == 1 ? Designer.color : Designer.colorBack;
      setBlockValue(tc, color);
      e.preventDefault();
    });
  }

  void setBlockValue(TableCellElement tc, int colorIndex) {
    int color = colorIndex - 1;
    if (color < 0) color = 0;
    tc.text = "${blockBaseValues[Designer.characterIndex] + color * 16}";
    tc.style.backgroundColor = Colors[colorIndex];
    print(tc.text);
  }

  void setTile(int x, int y, TableCellElement tc) {
    tc
      ..title = "@${x + y * 32} [$x $y]"
      ..style.width = "12px"
      ..style.height = "24px"
      ..style.fontSize = "0px"
      ..text = "143";
  }

  void toggleGrid() {
    editorGrid.setCellSpacing(Designer.gridDisplayed ? 0 : 1);
    Designer.gridDisplayed = !Designer.gridDisplayed;
  }
}
