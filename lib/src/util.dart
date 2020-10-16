import 'dart:convert';

int minNonNullIndex(List list) {
  if (list.length == 1) {
    return 0;
  }

  var minIdx;
  var idx = list.length;
  while (idx-- != 0) {
    if (list[idx] != null && (minIdx == null || list[idx] < list[minIdx])) {
      minIdx = idx;
    }
  }

  return minIdx;
}

String beautify(Map json) => JsonEncoder.withIndent('  ').convert(json);

String enumValue(Object value) => value.toString().split('').last;
