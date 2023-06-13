import 'package:flutter/material.dart';
import 'package:projecttpm/loginpage.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({ Key? key }) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Are you sure want to Logout?'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red
              ),
              onPressed: () {
              
            }, child: Text("yes"))
          ],
        ),
      ),
    );
  }
}