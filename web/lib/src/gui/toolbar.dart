import 'dart:html';
import '../designer.dart';
import '../events.dart';
import '../dragon.dart';
import '../util/tablebuilder.dart';
import 'charpalette.dart';
import 'gui.dart';
import 'palette.dart';

class Toolbar {
  final TableBuilder layout = new TableBuilder(5, 1);
  final DivElement toolbar = new DivElement();
  final DivElement charbar = new DivElement();

  final ButtonElement clearScreenButton = new ButtonElement();
  final ButtonElement hideGridButton = new ButtonElement();
  final ButtonElement githubButton = new ButtonElement();
  final ButtonElement helpButton = new ButtonElement();
  final ButtonElement generateCodeButton = new ButtonElement();

  Palette paletteForeground;
  Palette paletteBackground;
  CharPalette paletteChars;

  void build(HtmlElement parent, Function clearScreen, Function toggleGrid) {
    parent.append(toolbar);
    layout.build(parent);

    buildPalettes();
    buildButtons(clearScreen, toggleGrid);

    styleElements();

    parent.append(new BRElement());

    parent.append(charbar);
  }

  void styleElements() {
    layout.table.style
      ..padding = '5px'
      ..borderRadius = '6px';

    toolbar.style
      ..position = 'absolute'
      ..top = '80px'
      ..left = '640px'
      ..backgroundColor = 'lightblue'
      ..border = "1px solid darkorange"
      ..borderRadius = '6px'
      ..padding = '5px'
      ..width = '140px';

    charbar.style
      ..backgroundColor = 'lightblue'
      ..border = "1px solid darkorange"
      ..borderRadius = '6px'
      ..padding = '5px'
      ..width = '600px'
      ..position = 'absolute'
      ..top = '585px'
      ..left = '20px';
  }

  void buildButtons(Function clearScreen, Function toggleGrid) {
    toolbar
      ..append(clearScreenButton)
      ..append(hideGridButton)
      ..append(new BRElement())
      ..append(new BRElement())
      ..append(generateCodeButton)
      ..append(new BRElement())
      ..append(new BRElement())
      ..append(new BRElement())
      ..append(githubButton)
      ..append(helpButton);

    clearScreenButton.text = "CLS";
    hideGridButton.text = "GRID";
    githubButton.text = "GITHUB";
    helpButton.text = "HELP";
    generateCodeButton.text = "CODE...";

    clearScreenButton.onClick.listen((MouseEvent e) {
      if (window.confirm("Are you sure?")) {
        clearScreen(Designer.colorBack);
      }
    });

    hideGridButton.onClick.listen((MouseEvent e) => toggleGrid());

    githubButton.onClick.listen((MouseEvent e) =>
        window.open("https://github.com/daftspaniel/blockdesigner", 'git'));

    helpButton.onClick.listen((MouseEvent e) => helpHandler());
    generateCodeButton.onClick.listen((MouseEvent e) => codeHandler());
  }

  void buildPalettes() {
    layout.table.style.backgroundColor = "gray";
    layout.cell(2, 0).style.width = "50px";

    layout.cell(0, 0).append(makeSpan('Foreground :'));
    paletteForeground = new Palette(EventNames.ForeChange, layout.cell(1, 0));

    layout.cell(3, 0).append(makeSpan('Background :'));
    paletteBackground = new Palette(EventNames.BackChange, layout.cell(4, 0));

    paletteForeground.palette.all[Designer.color].text = "X";
    paletteBackground.palette.all[Designer.colorBack].text = "X";

    paletteChars = new CharPalette(EventNames.ForeChange, charbar);
  }

  void helpHandler() {
    DivElement helpbox = createUIBox();
    helpbox.style.height = "100%";
    String helpText = "<h1>Help</h1>";
    helpText += "<p>Press keys 1-9 to change Foreground Color.</p>";
    helpText += "<p>Left Mouse Button : Foreground.</p>";
    helpText += "<p>Right Mouse Button : Background.</p>";
    helpText += "<p>Hold Mouse Buttons to paint multiple blocks.</p>";
    helpText += "<p>Select block shapes press 'QWERTYUIOPASDFGH'.</p>";
    helpText += "<h1>Retro Links</h1>";
    helpText +=
        '<p><a target="_blank" href="http://cocobotomy.roust-it.dk/sgedit/">Cocobotomy Screen Designer</a> - similar tool a much more authentic look!</p>';
    helpText += "";

    helpbox.setInnerHtml(helpText, treeSanitizer: new NullTreeSanitizer());

    addCloseButton(helpbox);
    document.body.append(helpbox);
  }

  void codeHandler() {
    DivElement codebox = createUIBox();
    codebox.innerHtml = "<h1>Code</h1>";
    codebox.innerHtml += "<pre>${makeCode()}</pre>";
    codebox.style.height = "75%";

    addCloseButton(codebox);
    document.body.append(codebox);
  }

  String makeCode() {
    String program = "";
    int lineno = 5000;
    TableCellElement td;

    for (int y = 0; y < 16; y++) {
      program = program + "\r\n$lineno DATA ";
      for (int i = 0; i < 32; i++) {
        td = Designer.editor.editorGrid.cell(i, y);
        program += td.text;
        if (i != 31) program = program + ",";
      }
      lineno = lineno + 10;
    }

    String progend = "\r\n";
    String progstart =
        '10 CLEAR2000:CLS\r\n20 FOR T=1024 TO 1535\r\n30 READ A:POKE T,A\r\n';
    progstart =
        progstart + '90 NEXT T\r\n100 A\$=INKEY\$:IFA\$="" THEN100\r\n999 END';

    return progstart + program + progend;
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
