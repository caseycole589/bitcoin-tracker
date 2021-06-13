import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> coinRates = {};
    for (var coin in cryptoList) {
      var url = Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency/?apikey=$coinApiKey');
      var resp = await http.get(url);
      if (resp.statusCode == 200) {
        var json = jsonDecode(resp.body);
        print(json['rate']);
        coinRates[coin] = json['rate'].toStringAsFixed(2);
      } else {
        print(resp.statusCode);
        throw 'Problem with the get request';
      }
    }
    return coinRates;
  }
}
