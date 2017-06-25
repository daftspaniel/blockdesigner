import 'dart:html';

class TableBuilder {

  int _width = 8;
  int _height = 8;

  List<TableCellElement> _listAll = new List<TableCellElement>();
  List<List<TableCellElement>> _gridAll = new List<List<TableCellElement>>();

  TableBuilder(this._width, this._height);

  void build(DivElement parent) {
    TableElement table = new TableElement();

    table.style.border = "1px solid gray";

    for (int rowY = 0; rowY < _height; rowY++) {
      TableRowElement row = table.insertRow(rowY);
      _gridAll.add(new List<TableCellElement>());

      for (int colX = 0; colX < _width; colX++) {
        TableCellElement cell = row.insertCell(colX);
        cell.text = "[$colX $rowY]";
        _listAll.add(cell);
        _gridAll[rowY].add(cell);
      }
    }

    parent
        .
    append
      (
        table
    );
  }

  void applyAll(Function action) {
    for (int rowY = 0; rowY < _height; rowY++) {
      for (int colX = 0; colX < _width; colX++) {
        action(colX, rowY, _gridAll[rowY][colX]);
      }
    }
  }

}