import 'package:mp_flutter_chart_demo/Kline.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';

extension KlineExt on Kline {
  Entry toClosePriceEntry(int index) {
    return Entry(x: index.toDouble(), y: this.closePrice, data: {
      'time': this.time
    });
  }
}

extension KlineListExt on List<Kline> {
  List<Entry> toClosePriceEntryList() {
    int index = 0;
    return map((e) => e.toClosePriceEntry(index++)).toList();
  }
}

extension EntryExt on Entry {
  int get time => (this.mData as Map)['time'];
}
