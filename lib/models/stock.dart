class Stock {
  Stock({this.symbol, this.name, this.price});

  String symbol;
  String name;
  double price;

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'name': name,
      'price': price,
    };
  }
}
