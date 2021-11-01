// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'NGN',
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
  'BNB',
  'LTC',
  'SOL',
  'BCH',
];
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'YOUR-API-KEY-HERE';

class CoinData {
  //CoinData(this.url);

  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String url =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=31016F05-6B44-479B-BD6C-FD9F0AD1FCAE';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double price = data['rate'];

        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
