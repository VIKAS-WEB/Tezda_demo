import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/Controller/AuthController.dart';

class Register extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final AuthController authController = Get.find();

  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildBackground(width),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildAnimatedText("Sign Up", 30, duration: 1500),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: buildInputForm(),
                  ),
                  SizedBox(height: 20),
                  buildAnimatedButton("Forgot Password?", 1700, onPressed: () {}),
                  SizedBox(height: 30),
                  buildRegisterButton(),
                  SizedBox(height: 30),
                  buildAnimatedButton("Create Account", 2000, onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBackground(double width) {
    return Container(
      height: 400,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -40,
            height: 400,
            width: width,
            child: FadeInUp(
              duration: Duration(seconds: 1),
              child: backgroundImage(),
            ),
          ),
          Positioned(
            height: 400,
            width: width + 20,
            child: FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: backgroundImage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildAnimatedText(String text, double fontSize, {required int duration}) {
    return FadeInUp(
      duration: Duration(milliseconds: duration),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromRGBO(49, 39, 79, 1),
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }

  Widget buildInputForm() {
    return FadeInUp(
      duration: Duration(milliseconds: 1700),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(196, 135, 198, .3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            buildInputField("User Name", usernameController),
            buildInputField("Email Address", emailController, isEmail: true),
            buildInputField("Password", passwordController, isPassword: true),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String hintText, TextEditingController controller, {bool isPassword = false, bool isEmail = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 15),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$hintText cannot be empty';
            }
            if (isEmail && !GetUtils.isEmail(value)) {
              return 'Please enter a valid email address';
            }
            if (isPassword && value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildAnimatedButton(String text, int duration, {required VoidCallback onPressed}) {
    return FadeInUp(
      duration: Duration(milliseconds: duration),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterButton() {
    return FadeInUp(
      duration: Duration(milliseconds: 1900),
      child: MaterialButton(
        onPressed: () {
          // Validate form before proceeding with registration
          if (_formKey.currentState?.validate() ?? false) {
            authController.register(
              emailController.text,
              passwordController.text,
              usernameController.text,
            );
          }
        },
        color: Color(0XFFfbd404),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        height: 50,
        child: Center(
          child: Text(
            "Register",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
