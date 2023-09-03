import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        hintColor: Colors.indigoAccent),

  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.;

    return Scaffold(
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title:const Text('Simple Interest Calculator'),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter principal amount';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'Enter Principal e.g. 12000',
                          labelStyle: textStyle,
                          errorStyle: const TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          hintText: 'In percent',
                          labelStyle: textStyle,
                          errorStyle: const TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              controller: termController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter time';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Term',
                                  hintText: 'Time in years',
                                  labelStyle: textStyle,
                                  errorStyle: const TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 15.0
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentItemSelected,
                              onChanged: (newValueSelected) {
                                // Your code to execute, when a menu item is selected from dropdown
                                _onDropDownItemSelected(newValueSelected!);
                              },
                            ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            //color: Theme.of(context).hintColor,
                            //textColor: Theme.of(context).primaryColorDark,
                            child: const Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  displayResult = _calculateTotalReturns();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            //color: Theme.of(context).primaryColorDark,
                            //textColor: Theme.of(context).primaryColorLight,
                            child: const Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = const AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}