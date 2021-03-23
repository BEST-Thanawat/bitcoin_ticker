import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

const CoinAPI = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
const CoinAPI2 = 'https://rest.coinapi.io/v1/exchangerate/ETH/';
const CoinAPI3 = 'https://rest.coinapi.io/v1/exchangerate/LTC/';
const CoinKEY = '';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  String coinBase;
  String coinQuote;
  double coinRate;
  String coinBase2;
  String coinQuote2;
  double coinRate2;
  String coinBase3;
  String coinQuote3;
  double coinRate3;
  // List<DropdownMenuItem<String>> androidDropdown() {
  //   return currenciesList.map((cur) {
  //     return new DropdownMenuItem<String>(
  //       child: new Text(cur),
  //       value: cur,
  //     );
  //   }).toList();
  // }
  //
  // Future getData() async {
  //   var uri = Uri.parse(CoinAPI + selectedCurrency);
  //   http.Response response = await http.get(uri, headers: {'X-CoinAPI-Key': CoinKEY});
  //
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     return jsonDecode(data);
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  Future<dynamic> getPrice() async {
    NetworkHelper networkHelper = NetworkHelper(CoinAPI + selectedCurrency);
    NetworkHelper networkHelper2 = NetworkHelper(CoinAPI2 + selectedCurrency);
    NetworkHelper networkHelper3 = NetworkHelper(CoinAPI3 + selectedCurrency);

    var currData = await networkHelper.getData();
    var currData2 = await networkHelper2.getData();
    var currData3 = await networkHelper3.getData();

    setState(() {
      coinBase = currData['asset_id_base'];
      coinQuote = currData['asset_id_quote'];
      coinRate = currData['rate'];
      coinBase2 = currData2['asset_id_base'];
      coinQuote2 = currData2['asset_id_quote'];
      coinRate2 = currData2['rate'];
      coinBase3 = currData3['asset_id_base'];
      coinQuote3 = currData3['asset_id_quote'];
      coinRate3 = currData3['rate'];
    });

    return currData;
  }

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
        onChanged: (value) async {
          setState(() {
            selectedCurrency = value;
            getPrice();
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
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
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
                  '1 $coinBase = $coinRate$selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 $coinBase2 = $coinRate2$selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 $coinBase3 = $coinRate3$selectedCurrency',
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
            child: getPicker(),
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
