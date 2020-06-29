class Kline {
    double closePrice;
    int time;

    Kline({this.closePrice, this.time});

    factory Kline.fromJson(Map<String, dynamic> json) {
        return Kline(
            closePrice: double.tryParse(json['C'].toString()) ?? 0.0,
            time: int.tryParse(json['T'].toString()) ?? 0,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['C'] = this.closePrice;
        data['T'] = this.time;
        return data;
    }
}