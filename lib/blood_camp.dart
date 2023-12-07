import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection, where;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class BloodCamp extends StatefulWidget {
  const BloodCamp({Key? key}) : super(key: key);

  @override
  _BloodCampState createState() => _BloodCampState();
}

class _BloodCampState extends State<BloodCamp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final String username = 'email';
  final String password = 'password';

  @override
  void initState() {
    super.initState();
    _venueController.text = '';
    _timeController.text = '';
    _cityController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upakrith'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Card
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'images/blooddonation.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Title(
                      color: Colors.black,
                      child: Text('Organise Blood Donation Camp'),
                    ),
                    TextFormField(
                      controller: _venueController,
                      decoration: InputDecoration(
                        labelText: 'Venue',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the venue';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the time';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the city';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        _cityController.text = value.toUpperCase();
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _addToDatabase();
                          // Add logic to send notifications to users
                          _showSuccessMessage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Text('Organise'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addToDatabase() async {
    try {
      final String username = 'mongodbusername';
      final String password = 'mongodbpassword';
      final String databaseName = 'upakrith';
      final String clusterEndpoint = 'link';

      final String uri =
          'mongodb+srv://$username:$password@$clusterEndpoint/$databaseName?retryWrites=true&w=majority';
      final Db db = await Db.create(uri);
      await db.open();

      final DbCollection bloodCampCollection = db.collection('blood_camps');

      await bloodCampCollection.insert({
        'venue': _venueController.text,
        'time': _timeController.text,
        'city': _cityController.text,
      });
      await _sendEmailNotifications(_cityController.text);

      await db.close();
    } catch (e) {
      print('Failed to add to the database: $e');
    }
  }

  Future<void> _sendEmailNotifications(String city) async {
    final smtpServer = gmail(username, password);

    final List<String> users = await _fetchUsersInCity(city);
    for (final user in users) {
      final message = Message()
        ..from = Address(username, 'Upakrith')
        ..recipients.add(user)
        ..subject = 'Blood Donation Camp in Your City'
        ..text =
            'There is a blood donation camp in your city at ${_venueController.text} on ${_timeController.text}.';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } catch (e) {
        print('Error sending email: $e');
      }
    }
  }

  Future<List<String>> _fetchUsersInCity(String city) async {
    try {
      final String username = 'mongodbusername';
      final String password = 'mongodbpassword';
      final String databaseName = 'upakrith';
      final String clusterEndpoint = 'link';

      final String uri =
          'mongodb+srv://$username:$password@$clusterEndpoint/$databaseName?retryWrites=true&w=majority';
      final Db db = await Db.create(uri);
      await db.open();

      final DbCollection usersCollection = db.collection('users');

      final Stream<String> usersCursor = await usersCollection
          .find(where.eq('city', city))
          .map((user) => user['email'] as String);

      final List<String> emailAddresses = await usersCursor.toList();

      await db.close();

      return emailAddresses;
    } catch (e) {
      print('Failed to fetch users in the city: $e');
      return [];
    }
  }

  void _showSuccessMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Organised Successfully'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearForm();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _venueController.text = '';
    _timeController.text = '';
    _cityController.text = '';
  }
}
