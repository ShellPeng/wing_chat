import 'package:flutter/material.dart';
import 'package:extended_text/extended_text.dart';

///emoji/image text
class EmojiText extends SpecialText {
  static const String flag = "[";
  final int start;
  EmojiText(TextStyle textStyle, {this.start})
      : super(EmojiText.flag, "]", textStyle);

  @override
  InlineSpan finishText() {
    // TODO: implement finishText
    var key = toString();
    if (EmojiUitl.instance.emojiMap.containsKey(key)) {
      //fontsize id define image height
      //size = 30.0/26.0 * fontSize
      final double size = 20.0;

      ///fontSize 26 and text height =30.0
      //final double fontSize = 26.0;

      return ImageSpan(AssetImage(EmojiUitl.instance.emojiMap[key]),
          actualText: key,
          imageWidth: size,
          imageHeight: size,
          start: start,
          fit: BoxFit.fill,
          margin: EdgeInsets.only(left: 2.0, right: 2.0));
    }

    return TextSpan(text: toString(), style: textStyle);
  }
}

class EmojiUitl {
  final Map<String, String> _emojiMap = new Map<String, String>();

  Map<String, String> get emojiMap => _emojiMap;
  List<String> emojiArray = [
    '[微笑]', '[撇嘴]', '[色]', '[发呆]', '[得意]', '[流泪]', '[害羞]',
    '[闭嘴]', '[睡]', '[大哭]', '[尴尬]', '[发怒]', '[调皮]', '[呲牙]',
    '[惊讶]','[难过]','[酷]','[冷汗]','[抓狂]','[吐]','[偷笑]',
    '[愉快]','[白眼]','[傲慢]','[饥饿]','[困]','[惊恐]','[流汗]',
    '[憨笑]','[悠闲]','[奋斗]','[咒骂]','[疑问]','[嘘]','[晕]',
    '[疯了]','[衰]','[骷髅]','[敲打]','[再见]','[擦汗]','[抠鼻]',
    '[鼓掌]','[糗大了]','[坏笑]','[左哼哼]','[右哼哼]','[哈欠]','[鄙视]',
    '[委屈]','[快哭了]','[阴险]','[亲亲]','[吓]','[可怜]','[菜刀]',
    '[西瓜]','[啤酒]','[篮球]','[乒乓]','[咖啡]','[饭]','[猪头]',
    '[玫瑰]','[凋谢]','[嘴唇]','[爱心]','[心碎]','[蛋糕]','[闪电]',
    '[炸弹]','[刀]','[足球]','[瓢虫]','[便便]','[月亮]','[太阳]',
    '[礼物]','[拥抱]','[强]','[弱]','[握手]','[胜利]','[抱拳]',
    '[勾引]','[拳头]','[差劲]','[爱你]','[NO]','[OK]',
  ];

  final String _emojiFilePath = "emoji";

  static EmojiUitl _instance;
  static EmojiUitl get instance {
    if (_instance == null) _instance = new EmojiUitl._();
    return _instance;
  }

  EmojiUitl._() {
    for (var emojiName in emojiArray) {
      _emojiMap["$emojiName"] = "$_emojiFilePath/$emojiName.png";
    }
  }
}
