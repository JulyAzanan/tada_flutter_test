import 'package:flutter/material.dart';
import 'package:get/get.dart';

EdgeInsets getMargin({
  double top = 0,
  double bottom = 0,
  double left = 0,
  double right = 0,
  double all = 0,
}) {
  if (all != 0) {
    return EdgeInsets.all(getSize(all));
  }
  return EdgeInsets.fromLTRB(
    getSize(left),
    getSize(top),
    getSize(right),
    getSize(bottom),
  );
}

getSize(double size) {
  return size + Get.pixelRatio;
}
