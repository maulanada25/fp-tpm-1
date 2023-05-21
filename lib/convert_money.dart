import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _KonversiUangState();
}

class _KonversiUangState extends State<MoneyPage> {

  final inputcontroller = TextEditingController();

  double usd = 0, yen = 0, won = 0;

  void calculate(){
    double inputMoney = double.tryParse(inputcontroller.text)?? 0;
    setState(() {
      usd = inputMoney * 0.000067;
      yen = inputMoney * 0.0092;
      won = inputMoney * 0.089;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:10 ,horizontal:20 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: inputcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Input IDR',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: calculate,
                child: Text('Convert')
            ),
            SizedBox(height: 15),
            Text('USD : $usd'),
            SizedBox(height: 15),
            Text('JPY : $yen'),
            SizedBox(height: 15),
            Text('KRW : $won')
          ],
        ),
      ),
    );
  }
}
