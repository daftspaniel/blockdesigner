import 'dart:html';

DivElement createUIBox() {
  DivElement box = new DivElement();
  box.style
    ..position = 'absolute'
    ..top = '0px'
    ..left = '0px'
    ..width = '100%'
    ..height = '300px'
    ..backgroundColor = 'whitesmoke'
    ..borderBottom = '4px black solid'
    ..padding = '5px'
    ..paddingLeft = '25px'
    ..overflowY = "scroll";
  return box;
}

void addCloseButton(DivElement targetbox) {
  DivElement xbutton = new DivElement();
  targetbox.append(xbutton);
  xbutton
    ..innerHtml = 'X'
    ..style.position = 'absolute'
    ..style.float = 'right'
    ..style.background = 'red'
    ..style.color = 'white'
    ..style.top = '10px'
    ..style.left = 'calc(100% - 70px)'
    ..style.padding = '5px';
  xbutton.onClick.listen((MouseEvent e) => targetbox.remove());
}


SpanElement makeSpan(String text) =>
    new SpanElement()
      ..text = text;
