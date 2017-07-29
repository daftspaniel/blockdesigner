import 'dart:html';
import '../designer.dart';
import '../dragon.dart';
import '../events.dart';
import '../util/tablebuilder.dart';

class CharPalette {
  final TableBuilder palette = new TableBuilder(16, 1);
  final String changeEventName;

  final TableBuilder ic = new TableBuilder(2, 2);
  final List<TableBuilder> chars = new List<TableBuilder>();
  final List<TableCellElement> foregroundCells = new List<TableCellElement>();

  CharPalette(this.changeEventName, HtmlElement parent) {
    palette..build(parent);
    palette.all.forEach(setBackground);

    subscribeToEvents();

    for (int i = 0; i < 16; i++) {
      TableBuilder ic = new TableBuilder(2, 2);
      ic.build(palette.all[i]);
      ic.table.style.borderSpacing = '0px';
      chars.add(ic);
      setBlockCharacter(ic, pattern[i]);
    }
  }

  void subscribeToEvents() {
    AppEvents.bus.subscribe(changeEventName, (Function dataProvider) {
      print(changeEventName + "CP");
      foregroundCells.forEach((TableCellElement tce) {
        tce.style.backgroundColor = Colors[dataProvider()];
      });
    });

    AppEvents.bus.subscribe(EventNames.BlockChange, (Function dataprovider) {
      palette.all[Designer.characterIndex].style.border = '';
      Designer.characterIndex = dataprovider();
      palette.all[Designer.characterIndex].style.border = '2px solid yellow';
    });
  }

  void setBlockCharacter(TableBuilder chars, String block) {
    for (int i = 0; i < 4; i++) {
      setCharacter(chars, i, block[i]);
      if (block[i] == "1") foregroundCells.add(chars.all[i]);
    }
  }

  void setCharacter(TableBuilder chars, int index, String onOff) {
    TableCellElement tce = chars.all[index];
    tce.style.backgroundColor = onOff == "1" ? '#00ff00' : '#000000';
    tce.style.width = "10px";
    tce.style.height = "15px";
  }

  setBackground(TableCellElement tce) {
    tce.style
      ..backgroundColor = Colors[Designer.color]
      ..width = "20px"
      ..height = "30px";
  }
}
