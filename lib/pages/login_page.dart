// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, prefer_final_fields, avoid_print, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:recipfood/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login"
        ),
      ),
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
          ),
          _title(),
          _loginForm(),
        ],
      ),
    );
  }

  Widget _title(){
    return Text(
      "Recip Food",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm(){
    return Expanded(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.90,
        height: MediaQuery.sizeOf(context).height * 0.90,
        child: Form(
          key: _loginFormKey,          // create formkey
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: "kminchelle",
                onSaved: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "Enter a username";
                  }
                },
                decoration: InputDecoration(
                  hintText: "Username",
                ),
              ),
              Container(
                height: 50,
              ),
              TextFormField(
                initialValue: "0lelplR",
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.length < 5){
                    return "Enter a valid password";
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              Container(
                height: 50,
              ),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(
              username!, 
              password!,
            );
            if (result) {
              Navigator.pushReplacementNamed(context, "/home");
            }else{
              StatusAlert.show(context,
                duration: const Duration(seconds: 2),
                title: 'Login failed',
                subtitle: 'Please try again',
                configuration: const IconConfiguration(
                  icon: Icons.error,
                ),
                maxWidth: 260, 
              );
            }
          }
        },
        child: Text(
          "Login"
        ),
      ),
    );
  }
}