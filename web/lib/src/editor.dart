import 'dart:html';
import 'dragon.dart';

import 'palette.dart';
import 'tablebuilder.dart';
import 'designer.dart';

class Editor {

  final TableBuilder editorGrid = new TableBuilder(32, 16);

  final ButtonElement clearScreenButton = new ButtonElement();
  final ButtonElement hideGridButton = new ButtonElement();
  final ButtonElement githubButton = new ButtonElement();
  final ButtonElement helpButton = new ButtonElement();
  final ButtonElement generateCodeButton = new ButtonElement();

  final DivElement screenBorder = new DivElement();
  final DivElement toolbar = new DivElement();

  void build(HtmlElement parent) {
    buildScreenBorder();

    buildToolbar();
    buildMainGrid(screenBorder);

    parent..append(toolbar)..append(new BRElement())..append(
        new BRElement())..append(screenBorder);
  }

  void buildScreenBorder() {
    screenBorder
      ..style.backgroundColor = 'black'
      ..style.borderRadius = '6px'
      ..style.padding = '40px'
      ..style.width = '550px';
  }

  void buildToolbar() {
    clearScreenButton.text = "CLS";
    hideGridButton.text = "GRID";
    githubButton.text = "GITHUB";
    helpButton.text = "HELP";
    generateCodeButton.text = "CODE...";

    clearScreenButton.onClick.listen((MouseEvent e) =>
        clearScreen(Designer.colorBack));
    hideGridButton.onClick.listen((MouseEvent e) =>
        toggleGrid());

    toolbar
      ..style.backgroundColor = 'lightblue'
      ..style.borderRadius = '6px'
      ..style.padding = '5px'
      ..style.width = '550px';


    buildPalette(toolbar);

    toolbar..append(clearScreenButton)..append(hideGridButton)..append(
        githubButton)..append(helpButton)..append(generateCodeButton);
  }

  void buildPalette(HtmlElement parent) {
    Palette paletteF = new Palette(parent);
    Palette paletteB = new Palette(parent);
  }

  void buildMainGrid(DivElement parent) {
    editorGrid
      ..build(parent)
      ..applyAll(setTitle)..applyAll(clickHandler);
    clearScreen(Designer.colorBack);

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

  void setTitle(int x, int y, TableCellElement tc) {
    tc.title = "$x $y";
    tc.style.width = "15px";
    tc.style.height = "20px";
  }

  void toggleGrid() {
    editorGrid.setCellSpacing(Designer.gridDisplayed ? 0 : 1);
    Designer.gridDisplayed = !Designer.gridDisplayed;
  }
}