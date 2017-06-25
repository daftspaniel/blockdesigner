import 'dart:html';

class TableBuilder {

  int _width = 8;
  int _height = 8;

  final List<TableCellElement> _listAll = new List<TableCellElement>();
  final List<List<TableCellElement>> _gridAll = new List<
      List<TableCellElement>>();
  final TableElement table = new TableElement();

  List<TableCellElement> get all => _listAll;

  TableBuilder(this._width, this._height);

  void build(DivElement parent) {
    table.style.borderSpacing = '1px';

    for (int rowY = 0; rowY < _height; rowY++) {
      TableRowElement row = table.insertRow(rowY);
      for (int colX = 0; colX < _width; colX++) {
        TableCellElement cell = row.insertCell(colX);
        if (rowY == 0) {
          _gridAll.add(new List<TableCellElement>());
        }
        _gridAll[colX].add(cell);
        _listAll.add(cell);
      }
    }

    parent.append(table);
  }

  void applyAll(Function action) {
    for (int rowY = 0; rowY < _height; rowY++) {
      for (int colX = 0; colX < _width; colX++) {
        action(colX, rowY, _gridAll[colX][rowY]);
      }
    }
  }

  void setCellSpacing(int i) {
    table.style.borderSpacing = '${i}px';
  }

  void setBorder(String border) {
    table.style.border = border;
  }

}