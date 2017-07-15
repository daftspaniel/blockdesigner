import 'dart:html';

class TableBuilder {
  final int _width;
  final int _height;

  final List<TableCellElement> _listAll = new List<TableCellElement>();
  final List<List<TableCellElement>> _gridAll =
      new List<List<TableCellElement>>();
  final TableElement table = new TableElement();

  List<TableCellElement> get all => _listAll;

  TableCellElement cell(int x, int y) => _gridAll[x][y];

  TableBuilder(this._width, this._height);

  void build(HtmlElement parent) {
    for (int rowY = 0; rowY < _height; rowY++) {
      TableRowElement row = table.insertRow(rowY);

      for (int colX = 0; colX < _width; colX++) {
        TableCellElement cell = row.insertCell(colX);
        _listAll.add(cell);
      }
    }

    _gridAll.clear();

    for (int colX = 0; colX < _width; colX++) {
      List<TableCellElement> gridColumn = new List<TableCellElement>();
      _gridAll.add(gridColumn);

      for (int rowY = 0; rowY < _height; rowY++) {
        gridColumn.add(_listAll[colX + (rowY * _width)]);
      }
    }

    parent.append(table);
  }

  void applyAll(Function action) {
    for (int colX = 0; colX < _width; colX++) {
      for (int rowY = 0; rowY < _height; rowY++) {
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

  void clearText() {
    _listAll.forEach((TableCellElement tce) {
      tce.innerHtml = '';
    });
  }

  void info() {
    print("Grid length ${_gridAll.length}");
  }
}
