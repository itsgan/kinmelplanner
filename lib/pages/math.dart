import 'package:flutter/material.dart';

class MathCalculation extends StatefulWidget {
  @override
  _MathCalculationState createState() => _MathCalculationState();
}

class _MathCalculationState extends State<MathCalculation> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController item = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextFormField(
                          controller: item,
                          decoration: InputDecoration(labelText: 'Item'),
                          validator: (value) => value.isEmpty
                              ? 'This Field can not be empty'
                              : null),
                      TextFormField(
                          controller: rate,
                          decoration: InputDecoration(labelText: 'Rate'),
                          keyboardType: TextInputType.number,
                          onChanged: (String rate) {},
                          validator: (value) => value.isEmpty
                              ? 'This Field can not be empty'
                              : null),
                      TextFormField(
                          // controller: quantity,
                          decoration: InputDecoration(labelText: 'Quantity'),
                          keyboardType: TextInputType.number,
                          onChanged: (String qty) {
                            setState(() {
                              amount.text =
                                  (int.parse(qty) * int.parse(rate.text))
                                      .toString();
                            });
                          },
                          validator: (value) => value.isEmpty
                              ? 'This Field can not be empty'
                              : null),
                      TextFormField(
                        controller: amount,
                        decoration: InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                      ),
                      // RaisedButton(
                      //     child: Text('Calculate'),
                      //     onPressed: () {
                      //       calculate();
                      //     })
                    ],
                  ),
                ],
              )),
        ));
  }
}
