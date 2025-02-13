import 'package:currency_converter/models/allcurrencies.dart';
import 'package:currency_converter/models/ratesmodel.dart';
import 'package:currency_converter/utils/key.dart';
import 'package:http/http.dart' as http;

Future<RatesModel> fetchRates() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?base=USD&app_id=$key'));
  final result = ratesModelFromJson(response.body);
  return result;
}

Future<Map> fetchCurrencies() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=$key'));
  final allCurrencies = allcurrenciesFromJson(response.body);
  return allCurrencies;
}

String convertusd(Map exchangeRates, String usd, String currency) {
  String output =
      ((exchangeRates[currency] * double.parse(usd)).toStringAsFixed(2))
          .toString();
  return output;
}

String convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String output = (double.parse(amount) /
          exchangeRates[currencybase] *
          exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return output;
}
