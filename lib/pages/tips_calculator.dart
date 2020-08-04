import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TipsCalculator extends StatefulWidget {
  @override
  _TipsCalculatorState createState() => _TipsCalculatorState();
}

class _TipsCalculatorState extends State<TipsCalculator> {
  double billAmount = 0;
  double tipAmount = 0;
  double totalAmount = 0;
  double personPay = 0;
  int tipPercentage = 0;
  int personCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tips Calculator')),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 125,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent.shade100.withOpacity(0.4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Total Per Person',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      Text(
                        '\$ ${personPay.toStringAsFixed(2)}',
                        textScaleFactor: 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  height: 275,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.redAccent.shade400.withOpacity(0.2)),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                            prefixText: 'Bill Amount: ',
                            prefixStyle: TextStyle(color: Colors.grey)),
                        onChanged: (value) {
                          setState(() {
                            billAmount = double.parse(value);
                            print(totalAmount);
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Split'),
                            Container(
                              margin: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          personCount = personCount + 1;
                                          tipAmount = (tipPercentage / 100) *
                                              billAmount;
                                          totalAmount = billAmount + tipAmount;
                                          personPay = totalAmount / personCount;

                                          print(personCount);
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        child: Icon(Icons.add),
                                      )),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 20,
                                    child: Text(
                                      personCount.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (personCount>1)
                                          personCount = personCount - 1;
                                          tipAmount = (tipPercentage / 100) *
                                              billAmount;
                                          totalAmount = billAmount + tipAmount;
                                          personPay = totalAmount / personCount;
                                          print(personCount);
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        child: Icon(Icons.remove),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Text('Tip'), Text('\$$tipAmount')],
                        ),
                      )
                    ],
                  )),
            ),
            Column(
              children: <Widget>[
                Text('$tipPercentage%'),
                Slider(
                    value: tipPercentage.toDouble(),
                    max: 100,
                    min: 0,
                    divisions: 20,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        tipPercentage = value.toInt();
                        tipAmount = (tipPercentage / 100) * billAmount;
                        totalAmount = billAmount + tipAmount;
                        personPay = totalAmount / personCount;
                        print(totalAmount);
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
