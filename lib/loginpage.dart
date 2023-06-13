import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecttpm/menu.dart';
import 'package:projecttpm/sqlite_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //ambil data
  List<Map<String, dynamic>> user = [];
  void userData() async {
    final data = await SQLHelper.getUser();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Container(
          // decoration: BoxDecoration(color: Colors.yellow),
          child: Center(
            child: Column(
              children: [
                // SizedBox(height: 15, ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: userController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        var user = await SQLHelper.getUserByLogin(
                            userController.text, passwordController.text);
                        print(user);
                        if (user.length > 0) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainMenu(),
                              ));
                        } else {
                          final snackBar =
                              SnackBar(content: Text("Login Failed"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                    // SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: () async {
                        await SQLHelper.tambahUser(
                            userController.text, passwordController.text);
                        print('User created');
                      },
                      child: Text("Register"),
                      style: ElevatedButton.styleFrom(primary: Colors.amber),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  //login check
  // void LoginCheck(){
  //   int length = user
  //   for
  // }

  //tambah data
  Future<void> register() async {
    await SQLHelper.tambahUser(userController.text, passwordController.text);
    userData();
  }

  //form tambah
  void modalForm() async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: userController,
                      decoration: const InputDecoration(hintText: 'Username'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await register();
                        },
                        child: Text("Register"))
                  ],
                ),
              ),
            ));
  }
}
