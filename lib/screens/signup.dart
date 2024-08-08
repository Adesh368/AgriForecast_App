import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location_app/reusable_widget/textfield.dart';
import 'package:location_app/screens/map.dart';
import 'package:location_app/screens/sign_in.dart';
import 'package:location_app/state/sign_up_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _key = GlobalKey<FormState>();
  String _enteredusername = '';
  String _enteremail = '';
  String _enterpassword = '';
  bool _obscureText = true;
  bool isLoading = true;
  String? errorMail;
  String? errorUserName;
  String? errorPassword;

  Future<void> _save() async {
    final authmodel =
        Provider.of<SignUpProvider>(context, listen: false).listofname!;
    var userDatas = json.encode({
      'email': authmodel.email,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', userDatas);
  }

  Future _submit() async {
    final isValid = _key.currentState!.validate();
    if (isValid) {
      _key.currentState!.save();
      setState(() {
        isLoading = false;
      });
      final response = await Provider.of<SignUpProvider>(context, listen: false)
          .signUp(
              mail: _enteremail,
              password: _enterpassword,
              username: _enteredusername);
      final responsedata = jsonDecode(response.body);
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });

      if (response.statusCode == 200) {
        _save();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          return const MapScreen();
        }));
      } else {
        setState(() {
          if (responsedata['errors']['email'][0] != null) {
            errorMail = responsedata['errors']['email'][0];
          }
          if (responsedata['errors']['username'][0] != null) {
            errorUserName = responsedata['errors']['username'][0];
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _key,
            child: Column(children: [
              if (errorMail != null)
                Text(
                  errorMail!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (errorUserName != null)
                Text(errorUserName!, style: const TextStyle(color: Colors.red)),
              if (errorPassword != null) Text(errorPassword!),
              TextfieldWidget(
                hintText: 'Username',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'please enter a valid username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredusername = value!;
                },
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(height: 20),
              TextfieldWidget(
                hintText: 'Email',
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return 'please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteremail = value!;
                },
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(height: 20),
              TextfieldWidget(
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enterpassword = value!;
                },
                obscureText: _obscureText,
                icons: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isLoading ? 'Sign Up' : 'loading...'),
              ),
              //const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const SignInScreen();
                  }));
                },
                child: const Text('Already have an account? Sign In'),
              ),
            ])),
      ),
    );
  }
}
