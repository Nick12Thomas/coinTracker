import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/Models/networking.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/Models/cards.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "AUD";
  String exchangeRate1 = '?';
  String exchangeRate2 = '?';

  final Networking networking = Networking();

  void updateExchangeRate() async {
    double? rateBTC = await networking.getExchangeRate('BTC', selectedCurrency);
    double? rateETH = await networking.getExchangeRate('ETH', selectedCurrency);

    setState(() {
      exchangeRate1 = rateBTC != null ? rateBTC.toStringAsFixed(2) : 'Error';
      exchangeRate2 = rateETH != null ? rateETH.toStringAsFixed(2) : 'Error';
    });
  }

  DropdownButton<String> androidPicker() {
    List<String> uniqueCurrencies =
    currenciesList.toSet().toList(); // Remove duplicates
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in uniqueCurrencies) {
      dropdownItems.add(
        DropdownMenuItem<String>(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      items: dropdownItems,
      value: selectedCurrency,
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            selectedCurrency = value;
          });
          updateExchangeRate(); // Fetch updated rate
        }
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedCurrency = currenciesList[value];
        });
        updateExchangeRate(); // Fetch updated rate
      },
      children: pickerItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      return androidPicker();
    } else {
      return Text("Picker not available for this platform");
    }
  }

  @override
  void initState() {
    super.initState();
    updateExchangeRate(); // Fetch initial rate on app start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Coin Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                // Display BTC and ETH rate cards
                Cards(
                  coin: 'BTC',
                  rate: exchangeRate1,
                  selectedCurrency: selectedCurrency,
                ),
                SizedBox(height: 60,),
                Cards(
                  coin: 'ETH',
                  rate: exchangeRate2,
                  selectedCurrency: selectedCurrency,
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blueAccent,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}