// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'lib/src/tablebuilder.dart';

void main() {
  querySelector('#output').text = 'Your Dart app is running.';
  TableBuilder tb = new TableBuilder(32, 16);
  tb.build(querySelector('#output'));
  tb.applyAll(setTitle);
}

void setTitle(int x, int y, TableCellElement tc) {
  tc.title = "$x $y";
  tc.text = "$x $y";
  print("$x $y");
}