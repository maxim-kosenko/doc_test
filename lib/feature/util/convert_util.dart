import 'package:flutter/cupertino.dart';

class AInterval {
  Duration start;
  Duration end;

  AInterval({
    @required this.start,
    @required this.end,
  });
}

Map<int, AInterval> convertToIntervalOfTime(String binary) {
  List<String> partsOfBinary = binary.split('').reversed.toList();
  List<int> indexes = partsOfBinary
      .asMap()
      .entries
      .where((element) => element.value == '1')
      .toList()
      .map((e) => e.key)
      .toList();
  List<int> pairs = [];
  if (indexes.isNotEmpty) {
    pairs.add(indexes.first);
    for (int i = 0; i < indexes.length - 1; i++) {
      if (indexes[i] + 1 != indexes[i + 1]) {
        pairs.add(indexes[i]);
        pairs.add(indexes[i + 1]);
      }
    }
    pairs.add(indexes.last);
  }
  return splitIntoPairs(pairs)
      .map((e) => AInterval(
          start: Duration(minutes: e[0] * 30),
          end: Duration(minutes: e[1] * 30 + 30)))
      .toList()
      .asMap();
}

String convertIntervalsToBinary(Map<int, AInterval> intervals) {
  List<int> indexes = [];
  intervals.entries.map((e) {
    indexes.add(e.value.start.inMinutes ~/ 30);
    indexes.add((e.value.end.inMinutes) ~/ 30);
  }).toList();
  List<String> partsOfBinary = List.generate(48, (index) {
    return '0';
  }).toList();
  splitIntoPairs(indexes).map((e) {
    partsOfBinary.replaceRange(
        e[0], e[1], List.generate(e[1] - e[0], (index) => '1'));
    return e;
  }).toList();
  return partsOfBinary.reversed.join();
}

int convertBinaryToInt(String binary) {
  return int.parse(binary, radix: 2);
}

String convertIntToBinary(int num) {
  return num.toRadixString(2);
}

String convertDurationToText(Duration duration) {
  String timeString = duration.toString();
  if (timeString.contains('24')) {
    timeString = timeString.replaceFirst('24', '00');
  }
  if (timeString.split(':').first.length < 2) {
    timeString ='0'+timeString;
  }
  return timeString.substring(0, timeString.lastIndexOf(':'));
}

List<List<int>> splitIntoPairs(List<int> list) {
  List<List<int>> pairs = [];
  for (var i = 0; i < list.length; i += 2) {
    pairs.add(list.sublist(i, i + 2 > list.length ? list.length : i + 2));
  }
  return pairs;
}

bool checkIsCorrectInterval(
  Map<int, AInterval> currentIntervals,
  AInterval newInterval,
) {
  bool isCorrect = true;
  Duration newStart = newInterval.start;
  Duration newEnd = newInterval.end;
  currentIntervals.entries.map((e) {
    Duration currentStart = e.value.start;
    Duration currentEnd = e.value.end;
    if (newStart.inMinutes < currentStart.inMinutes &&
            newEnd.inMinutes > currentStart.inMinutes ||
        newStart.inMinutes < currentEnd.inMinutes &&
            newEnd.inMinutes > currentEnd.inMinutes ||
        newStart.inMinutes >= currentStart.inMinutes &&
            newEnd.inMinutes <= currentEnd.inMinutes) {
      isCorrect = false;
    }
    return e;
  }).toList();
  return isCorrect;
}
