import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezda_task/Controller/AuthController.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController authController = Get.find();
  String username = 'No Name';
  String email = 'No Email';
  String? profileImage; // Store image path

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'No Name';
      email = prefs.getString('email') ?? 'No Email';
      profileImage = prefs.getString('profileImage'); // Fetch image path
    });
  }

  Future<void> _editProfile(BuildContext context) async {
    TextEditingController usernameController =
        TextEditingController(text: username);
    TextEditingController emailController = TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _saveUserInfo(usernameController.text, emailController.text);
                Get.back(); // Close the dialog
              },
              child: Text("Update"),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog without saving
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveUserInfo(String newUsername, String newEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
    await prefs.setString('email', newEmail);

    // Update the state to reflect new values
    setState(() {
      username = newUsername;
      email = newEmail;
    });

    Get.snackbar(
      'Success',
      'Profile updated successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20), // Spacing
              Text(
                username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8), // Spacing
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20), // Spacing
              ElevatedButton(
                onPressed: () {
                  _editProfile(context);
                },
                child: Text("Edit Profile"),
              ),
              SizedBox(height: 20), // Spacing
              ElevatedButton(
                onPressed: () {
                  authController.logout();
                  // Action for logging out
                },
                child: Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
