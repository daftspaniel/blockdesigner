import 'dart:html';
import 'designer.dart';
import 'events.dart';
import 'palette.dart';
import 'util/tablebuilder.dart';

class Toolbar {

  final TableBuilder layout = new TableBuilder(5, 1);
  final DivElement toolbar = new DivElement();

  final ButtonElement clearScreenButton = new ButtonElement();
  final ButtonElement hideGridButton = new ButtonElement();
  final ButtonElement githubButton = new ButtonElement();
  final ButtonElement helpButton = new ButtonElement();
  final ButtonElement generateCodeButton = new ButtonElement();

  Palette paletteForeground;
  Palette paletteBackground;

  void build(HtmlElement parent, Function clearScreen, Function toggleGrid) {
    layout.build(parent);
    buildButtons(clearScreen, toggleGrid);

    toolbar.style
      ..backgroundColor = 'lightblue'
      ..border = "1px solid darkorange"
      ..borderRadius = '6px'
      ..padding = '5px'
      ..width = '550px';

    buildPalettes();

    toolbar..append(clearScreenButton)..append(hideGridButton)..append(
        githubButton)..append(helpButton)..append(generateCodeButton);
    parent.append(toolbar);
  }

  void buildButtons(Function clearScreen, Function toggleGrid) {
    clearScreenButton.text = "CLS";
    hideGridButton.text = "GRID";
    githubButton.text = "GITHUB";
    helpButton.text = "HELP";
    generateCodeButton.text = "CODE...";

    clearScreenButton.onClick.listen((MouseEvent e) =>
        clearScreen(Designer.colorBack));
    hideGridButton.onClick.listen((MouseEvent e) =>
        toggleGrid());
  }


  void buildPalettes() {
    layout.table.style.backgroundColor = "yellow";

    layout.cell(0, 0).append(makeSpan('Foreground :'));
    paletteForeground = new Palette(layout.cell(1, 0));

    layout.cell(2, 0).style.width = "100px";

    layout.cell(3, 0).append(makeSpan('Background :'));
    paletteBackground = new Palette(layout.cell(4, 0));

    paletteForeground.palette.all[Designer.color].text = "X";
    paletteBackground.palette.all[Designer.colorBack].text = "X";
  }



  SpanElement makeSpan(String text) =>
      new SpanElement()
        ..text = text;
}