import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, where;
import 'package:geolocator/geolocator.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  bool _isMedicalProfessional = false;
  TextEditingController _locationController = TextEditingController();

  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(labelText: 'State'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                ),
                CheckboxListTile(
                  title: Text('Medical Professional'),
                  value: _isMedicalProfessional,
                  onChanged: (value) {
                    setState(() {
                      _isMedicalProfessional = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () async {
                        await _getCurrentLocation();
                      },
                    ),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _signup();
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signup() async {
    try {
      final String username = 'mongodbusername';
      final String password = 'mongodbpassword';
      final String databaseName = 'upakrith';
      final String clusterEndpoint = 'link';

      final String uri =
          'mongodb+srv://$username:$password@$clusterEndpoint/$databaseName?retryWrites=true&w=majority';
      final Db db = await Db.create(uri);
      await db.open();

      final existingUser = await db
          .collection('users')
          .findOne(where.eq('email', _emailController.text));

      if (existingUser != null) {
        _showUserExistsDialog();
      } else {
        await db.collection('users').insert({
          'name': _nameController.text.toUpperCase(),
          'email': _emailController.text,
          'phone': _phoneController.text,
          'city': _cityController.text.toUpperCase(),
          'state': _stateController.text.toUpperCase(),
          'isMedicalProfessional': _isMedicalProfessional,
          'latitude': _latitude,
          'longitude': _longitude,
        });

        print('User signed up successfully!');
      }

      await db.close();
    } catch (e) {
      print('Failed to sign up: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _locationController.text = 'Lat: $_latitude, Lng: $_longitude';
      });
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  void _showUserExistsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Already Exists'),
          content: Text(
              'The provided email address is already associated with an existing account.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
