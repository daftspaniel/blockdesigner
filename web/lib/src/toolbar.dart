import 'dart:html';
import 'designer.dart';
import 'palette.dart';
import 'util/tablebuilder.dart';

class Toolbar {

  final TableBuilder layout = new TableBuilder(3, 3);
  final DivElement toolbar = new DivElement();
  final ButtonElement clearScreenButton = new ButtonElement();
  final ButtonElement hideGridButton = new ButtonElement();
  final ButtonElement githubButton = new ButtonElement();
  final ButtonElement helpButton = new ButtonElement();
  final ButtonElement generateCodeButton = new ButtonElement();

  Palette paletteForeground;
  Palette paletteBackground;

  void build(DivElement parent, Function clearScreen, Function toggleGrid) {
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
    layout.cell(0, 1).append(new SpanElement()..text = 'Foreground :');
    paletteForeground = new Palette(layout.cell(0, 1));

    layout.cell(0, 2).append(new SpanElement()..text = 'Background :');
    paletteBackground = new Palette(layout.cell(0, 2));

    paletteForeground.palette.all[Designer.color].text = "X";
    paletteBackground.palette.all[Designer.colorBack].text = "X";
  }
}