// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

// ignore: use_key_in_widget_constructors
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  Map<String, String> coinValues = {};
  CoinData coinData = CoinData(); // creating instance of coindata class
  // FUNCTION FOR ANDROID PICKER

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value.toString();
            getData();
          },
        );
      },
    );
  }
  // FUNCTION FOR IOS PICKER

  CupertinoPicker iOSPicker() {
    List<Text> textList = [];
    for (String currency in currenciesList) {
      textList.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedItem) {
        // ignore: unused_local_variable
        var selectedCurrency = selectedItem;
        getData();
      },
      children: textList,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      //We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }
  //  Column makeCards() {
//    List<CryptoCard> cryptoCards = [];
//    for (String crypto in cryptoList) {
//      cryptoCards.add(
//        CryptoCard(
//          cryptoCurrency: crypto,
//          selectedCurrency: selectedCurrency,
//          value: isWaiting ? '?' : coinValues[crypto],
//        ),
//      );
//    }
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: cryptoCards,
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                  value: isWaiting ? '?' : coinValues['BTC'],
                  selectedCurrency: selectedCurrency,
                  cryptoCurrency: 'BTC'),
              CryptoCard(
                  value: isWaiting ? '?' : coinValues['ETH'],
                  selectedCurrency: selectedCurrency,
                  cryptoCurrency: 'ETH'),
              CryptoCard(
                  value: isWaiting ? '?' : coinValues['LTC'],
                  selectedCurrency: selectedCurrency,
                  cryptoCurrency: 'LTC'),
              CryptoCard(
                  value: isWaiting ? '?' : coinValues['BNB'],
                  selectedCurrency: selectedCurrency,
                  cryptoCurrency: 'BNB'),
              CryptoCard(
                  value: isWaiting ? '?' : coinValues['SOL'],
                  selectedCurrency: selectedCurrency,
                  cryptoCurrency: 'SOL'),
              CryptoCard(
                  value: isWaiting ? '?' : coinValues['BCH'],
                  selectedCurrency: selectedCurrency,
                  cryptoCurrency: 'BCH'),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CryptoCard(
      {required this.value,
      required this.selectedCurrency,
      required this.cryptoCurrency});

  final String? value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
