import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Networking {
  final String baseUrl = dotenv.env['BASE_URL'] ?? ''; // Get base URL
  final String apiKey = dotenv.env['API_KEY'] ?? ''; // Get API Key

  Future<double?> getExchangeRate(String baseCurrency, String targetCurrency) async {
    final url = '$baseUrl/$baseCurrency/$targetCurrency';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-CoinAPI-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['rate']; // Returns the exchange rate
      } else {
        print('Failed to fetch data: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error while fetching exchange rate: $e');
      return null;
    }
  }
}