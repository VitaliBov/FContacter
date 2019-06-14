import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AppDebugger {
  static bool isAndroid; // isAndroid = true, isIos = false

  static printLog(String string) => print('FContacter: $string');

  static printWidgetsTree() => debugDumpApp();

  static printRenderingTree() => debugDumpRenderTree();

  static printLayoutsTree() => debugDumpLayerTree();

  static printLayoutSizeTree(DebugSemanticsDumpOrder childOrder) => debugDumpSemanticsTree(childOrder);

  static enableLayoutBounds(bool isEnable) => debugPaintSizeEnabled = isEnable;

  static enableAnimationSlowly() => timeDilation = 4;
}