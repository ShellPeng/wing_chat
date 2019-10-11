import 'emoji_text.dart';
import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';

class PPSpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  final BuilderType type;
  PPSpecialTextSpanBuilder({this.type: BuilderType.extendedText});

  @override
  SpecialText createSpecialText(String flag,
      {TextStyle textStyle, SpecialTextGestureTapCallback onTap, int index}) {
    if (flag == null || flag == "") return null;
    // TODO: implement createSpecialText

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, EmojiText.flag)) {
      return EmojiText(textStyle, start: index - (EmojiText.flag.length - 1));
    }
    return null;
  }
}

enum BuilderType { extendedText, extendedTextField }
