// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'lib/src/designer.dart';
import 'lib/src/editor.dart';

final Editor editor = new Editor();
final HtmlElement parent = querySelector('#output');

void main() {
  editor.build(parent);
  Designer.init();
  Designer.editor = editor;
}
