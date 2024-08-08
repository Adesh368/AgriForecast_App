import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location_app/reusable_widget/textfield.dart';
import 'package:location_app/screens/map.dart';
import 'package:location_app/screens/signup.dart';
import 'package:location_app/state/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SignInScreen> {
  final _key = GlobalKey<FormState>();
  bool _obscureText = true;
  String _enteremail = '';
  String _enterpassword = '';
  bool isLoading = true;
  String? errorMessage;

  Future<void> _save() async {
    final authmodel =
        Provider.of<SignInProvider>(context, listen: false).listofname!;
    var userDatas = json.encode({
      'email': authmodel.email,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', userDatas);
  }

  void _submit() async {
    final isValid = _key.currentState!.validate();
    if (isValid) {
      _key.currentState!.save();
      setState(() {
        isLoading = false;
      });
      final response = await Provider.of<SignInProvider>(context, listen: false)
          .userSignIn(_enteremail, _enterpassword);
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
          errorMessage = responsedata['message'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _key,
            child: Column(children: [
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
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
                    return 'Password must be up to 6 characters';
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
                child: Text(isLoading ? 'Sign In' : 'loading...'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const SignupScreen();
                  }));
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ])),
      ),
    );
  }
}
