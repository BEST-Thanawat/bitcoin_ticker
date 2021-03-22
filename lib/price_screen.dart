import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  // List<DropdownMenuItem<String>> androidDropdown() {
  //   return currenciesList.map((cur) {
  //     return new DropdownMenuItem<String>(
  //       child: new Text(cur),
  //       value: cur,
  //     );
  //   }).toList();
  // }

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: currenciesList.map((cur) {
          return new DropdownMenuItem<String>(
            child: new Text(cur),
            value: cur,
          );
        }).toList(),
        hint: Text('Please choose a currency'),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: currenciesList.map((cur) {
        return new Text(cur);
      }).toList(),
      //children: [Text('USD'), Text('EUR'), Text('THB')],
    );
  }

  Widget getPicker() {
    if (iOS) {
      return iOSPicker();
    } else if (android) {
      return androidDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
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
                  '1 BTC = ? USD',
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
            color: Colors.lightBlue,
            child: androidDropdown(),
            //child: iOSPicker(),
            // child: DropdownButton<String>(
            //     value: selectedCurrency,
            //     items: androidDropdown(),
            //     hint: Text('Please choose a currency'),
            //     onChanged: (value) {
            //       setState(() {
            //         selectedCurrency = value;
            //       });
            //     }),
          ),
        ],
      ),
    );
  }
}
