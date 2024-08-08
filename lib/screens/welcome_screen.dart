import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location_app/reusable_widget/logo.dart';
import 'package:location_app/screens/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? email;

  @override
  void initState() {
    _getUserEmail();
    super.initState();
  }

  Future<void> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      email = extracteduserdata['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if(email == null){
      return const Text('');
    }
    return Scaffold(
      appBar: AppBar(
          title: const Row(children: [
            Logo(), // Display your logo
            SizedBox(width: 10),
            Text('AgriForecast'),
          ]),
          ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Welcome to AgriForecast! ${email!.substring(0, 5)}',
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (email != null) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (ctx) {
                  return const MapScreen();
                }));
              }
            },
            child: const Text('Select Location'),
          ),
          // Other buttons to navigate to different parts of the app
        ]),
      ),
    );
  }
}
