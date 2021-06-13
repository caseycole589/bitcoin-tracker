import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import "dart:io" show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  bool waiting = true;
  Map<String, String> coinValues = {};

  void getData() async {
    try {
      setState(() {
        waiting = true;
      });
      var data = await CoinData().getCoinData(selectedCurrency);
      setState(() {
        coinValues = data;
        waiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: [
        for (String item in currenciesList)
          DropdownMenuItem(
            child: Text(item),
            value: item,
          ),
      ],
      onChanged: (String value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker applePicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          getData();
        });
      },
      children: [
        for (String item in currenciesList)
          Text(item, style: TextStyle(color: Colors.white))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${waiting ? '?' : coinValues['BTC']} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? applePicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
