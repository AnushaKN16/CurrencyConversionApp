import 'package:currency_converter/services/service.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdToAny({super.key, required this.rates, required this.currencies});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'INR';
  String answer = 'Converted Currency will be shown here :)';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('USD to Any Currency'),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: const ValueKey('usd'),
              controller: usdController,
              decoration: const InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.grey.shade400,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      answer =
                          '${usdController.text} USD = ${convertusd(widget.rates, usdController.text, dropdownValue)} $dropdownValue';
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  child: const Text('Convert'),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(answer)
          ],
        ),
      ),
    );
  }
}
