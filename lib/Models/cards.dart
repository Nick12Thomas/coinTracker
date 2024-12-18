import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String coin;
  final String rate;
  final String selectedCurrency;

  Cards({
    required this.coin,
    required this.rate,
    required this.selectedCurrency,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Column(
          children: [
            Text(
              '1 $coin = $rate $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}