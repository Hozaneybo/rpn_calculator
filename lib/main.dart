import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'logic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  _MyAppState createState() => _MyAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Adjust the main theme color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RPNCalculator(),
    );
  }
}

class RPNCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<RPNCalculator> {
  final Calculator _calculator = Calculator();
  String _firstInput = "";
  String _secondInput = "";
  String _result = "";
  String _operation = "";
  int num = 0;


  void _handleNumber(String value) {
    setState(() {
      if ( _operation.isEmpty && (num == 0 )) {
        _firstInput += value;
      } else if (_operation.isEmpty && (num != 0)) {
        _secondInput += value;
      }
    });
  }

  void _enterPressed() {
    setState(() {
      if (_firstInput.isNotEmpty && _secondInput.isEmpty) {
        _calculator.push(double.parse(_firstInput));
        num ++;
      } else if (_firstInput.isNotEmpty && _secondInput.isNotEmpty && _result.isEmpty) {
        _calculator.push(double.parse(_secondInput));
      } else if(_firstInput.isNotEmpty && _secondInput.isNotEmpty && _result.isNotEmpty){
        _firstInput = _result ;
        _secondInput = "";
        _result = "";
      }
    });
  }

  void _handleOperation(String value) {
    setState(() {
      _operation = value;
      if (!_secondInput.isEmpty) {
        _calculator.push(double.parse(_secondInput));
        performCalculation();
      }
    });
  }

  void performCalculation() {
    if (!_operation.isEmpty) {
      _calculator.performOperation(_operation);
      if (_calculator.stack.isNotEmpty) {
        _result = _calculator.stack.last.toString();
      }
      _operation = "";
    }
  }

  void _clearAll() {
    setState(() {
      _calculator.clear();
      _firstInput = "";
      _secondInput = "";
      _result = "";
      _operation = "";
      num = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    // Obtain the current media query data
    var mediaQuery = MediaQuery.of(context);
    // Calculate the number of columns for the GridView based on the width of the screen
    int gridCount = mediaQuery.size.width > 600 ? 8 : 4;
    // Calculate the appropriate padding
    double padding = mediaQuery.size.width > 600 ? 16.0 : 8.0;
    // Calculate the size ratio for the buttons based on the screen width
    double buttonWidth = (mediaQuery.size.width - padding * (gridCount + 1)) / gridCount;
    double buttonHeight = buttonWidth * 0.6; // Maintain the aspect ratio of the buttons

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          title: const Text('RPN Calculator',
            style: TextStyle(
                fontSize: 22,
                color: Colors.white
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      color: Colors.blueGrey[300],
                      child: ListTile(
                          leading : Text('input 1:' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)) ,
                          trailing: Text(_firstInput, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                      ),
                    ),
                    Card(
                      color: Colors.blueGrey[300],
                      child: ListTile(
                          leading : Text('input 2:' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))  ,
                          trailing: Text(_secondInput, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), )
                      ),
                    ),
                    Card(
                      color: Colors.blueGrey[300],
                      child: ListTile(
                          leading : Text('Result :' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))  ,
                          trailing: Text(_result, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.all(8.0),
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: (7/6),
                children: <Widget>[
                  ...['7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '0', '.', 'Enter', '+']
                      .map((key) {
                    return GridTile(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[800], // Button background color
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 5, // Button shadow
                        ),
                        child: Text(key),
                        onPressed: () {
                          if(['1', '2','3','4','5','6','7','8','9','0', '.'].contains(key)){
                            _handleNumber(key);
                          }
                          if (key == 'Enter') {
                            _enterPressed();
                          } else if (['/', '*', '-', '+'].contains(key)) {
                            _handleOperation(key);
                          }
                        },
                      ),
                    );
                  }).toList(),
                  GridTile(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(40.0, 20.0) ,
                        backgroundColor: Colors.redAccent, // Button background color
                        foregroundColor: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 5, // Button shadow
                      ),
                      child: Text('Clear'),
                      onPressed: (){_clearAll();},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}