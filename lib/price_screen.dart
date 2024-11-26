import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "AUD";

  // List<DropdownMenuItem<String>> getDropdownItems() {
  //   List<String> uniqueCurrencies =
  //       currenciesList.toSet().toList(); // remove duplicate
  //   List<DropdownMenuItem<String>> dropdownItems = [];
  //   for (String currency in uniqueCurrencies) {
  //     dropdownItems.add(DropdownMenuItem<String>(
  //       child: Text(currency),
  //       value: currency,
  //     ));
  //   }
  //   return dropdownItems;
  // }

  List<Widget> getPickerItem() {
    List<Text> pickerItem = [];
    for (String currency in currenciesList) {
      pickerItem.add(Text(currency));
    }
    return pickerItem;
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? $selectedCurrency',
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
            color: Colors.blueAccent,
            child: CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedCurrency = currenciesList[value];
                });
              },
              children: getPickerItem(),
            ),
          ),
        ],
      ),
    );
  }
}
