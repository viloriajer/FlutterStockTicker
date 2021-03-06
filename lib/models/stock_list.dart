//This module takes in a list and converts it to
//and then returns a ListView Widget populated with
//ListTiles.

//ListView Widget of the Week
//https://www.youtube.com/watch?v=KJpkjHGiI5A&vl=en

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'stock.dart';

class StockList extends StatefulWidget {
  StockList({this.stocks});

  final List<Stock> stocks;

  @override
  State<StatefulWidget> createState() {
    return new _StockListState();
  }
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    return _buildStockList(context, widget.stocks);
  }

  ListView _buildStockList(context, List<Stock> stocks) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Symbol: ${stocks[index].symbol}'),
          subtitle: Text('Name: ${stocks[index].name}'),
          trailing: Text('Price: \$${stocks[index].price}'),
        );
      },
    );
  }
}
