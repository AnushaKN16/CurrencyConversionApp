import 'package:currency_converter/models/ratesmodel.dart';
import 'package:currency_converter/services/service.dart';
import 'package:currency_converter/widgets/anyToAny.dart';
import 'package:currency_converter/widgets/usdToAny.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<RatesModel> result;
  late Future<Map> allCurrencies;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchRates();
      allCurrencies = fetchCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Exchange"),
      ),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/currency.jpeg'),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Form(
              child: FutureBuilder(
                  future: result,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: FutureBuilder(
                          future: allCurrencies,
                          builder: (context, currSnapshot) {
                            if (currSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                UsdToAny(
                                  rates: snapshot.data?.rates,
                                  currencies: currSnapshot.data!,
                                ),
                                AnyToAny(
                                  rates: snapshot.data?.rates,
                                  currencies: currSnapshot.data!,
                                )
                              ],
                            );
                          }),
                    );
                  }))),
        ),
      ),
    );
  }
}
