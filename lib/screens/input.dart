import 'package:flutter/material.dart';
import 'package:location_app/reusable_widget/logo.dart';
import 'package:location_app/reusable_widget/textfield.dart';
import 'package:location_app/screens/response_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({
    required this.city,
    super.key,
  });

  final String city;
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _key = GlobalKey<FormState>();
  String _enteredcrop = '';
  String _enteredyear = '';
  String _enteredlan = '';

  Future _submit() async {
    final isValid = _key.currentState!.validate();
    if (isValid) {
      _key.currentState!.save();
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return ResponseScreen(
            crop: _enteredcrop,
            language: _enteredlan,
            location: widget.city,
            year: _enteredyear);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Logo(), // Display the logo
            SizedBox(width: 10),
            Text('AgriForecast'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextfieldWidget(
                hintText: 'Crop',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid crop';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredcrop = value!;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 20),
              TextfieldWidget(
                hintText: 'Year',
                validator: (value) {
                  if (value == null || value.trim().length > 4) {
                    return 'Please enter a valid year';
                  }
                  int value1 = int.tryParse(value)!;
                  final currentdate = DateTime.now();

                  if (value1 < currentdate.year) {
                    return 'Please enter a valid year greater than ${currentdate.year}';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredyear = value!;
                },
                textinput: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextfieldWidget(
                hintText: 'Language:English Or French',
                validator: (value) {
                  //String? text = value;
                  if (value?.trim() != 'English' && value?.trim() != 'French') {
                    return 'Please enter valid language';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredlan = value!;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Get Forecast'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
