import 'package:finalproject/siezure.dart';
import 'package:flutter/material.dart';
import 'allergic_reaction.dart';
import 'burn_damage.dart';
import 'cpr.dart';
import 'first_aid.dart';
import 'organ_donation.dart';
import 'signup.dart';
import 'blood_camp.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upakrith',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upakrith'),
        backgroundColor: Colors.redAccent,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'Organ Donation') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrganDonationApp(),
                  ),
                );
              } else if (value == 'Blood Donation') {
                //blood donation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BloodCamp(),
                  ),
                );
              } else if (value == 'Sign Up') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupForm(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Home', 'Organ Donation', 'Blood Donation', 'Sign Up'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.redAccent),
                      minimumSize: Size(double.infinity, 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllergyReactionApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Allergic Reaction',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.redAccent),
                      minimumSize: Size(double.infinity, 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CPRApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Perform CPR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.redAccent),
                      minimumSize: Size(double.infinity, 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirstAidApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'First Aid',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.redAccent),
                      minimumSize: Size(double.infinity, 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BurnDamgeApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Burn Damage',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.redAccent),
                      minimumSize: Size(double.infinity, 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeizureApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Seizures',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      side: BorderSide(color: Colors.white),
                      minimumSize: Size(double.infinity, 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () async {
                      await _pingLocation(context);
                    },
                    child: const Text(
                      'Ping Your Location',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pingLocation(BuildContext context) async {
    try {
      Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String nearestMedicalProfessionalEmail =
          await _fetchNearestMedicalProfessional(
        userLocation.latitude,
        userLocation.longitude,
      );

      await _sendEmailToNearestProfessional(
        userLocation,
        nearestMedicalProfessionalEmail,
        context,
      );
    } catch (e) {
      print('Error while pinging location: $e');
    }
  }

  Future<String> _fetchNearestMedicalProfessional(
      double latitude, double longitude) async {
    try {
      final String username = 'mongodbusername';
      final String password = 'mongodbpassword';
      final String databaseName = 'upakrith';
      final String clusterEndpoint = 'link';

      final String uri =
          'mongodb+srv://$username:$password@$clusterEndpoint/$databaseName?retryWrites=true&w=majority';
      final Db db = await Db.create(uri);
      await db.open();

      final usersCollection = db.collection('users');

      await usersCollection.createIndex(
        keys: {'location': '2dsphere'},
      );

      final allProfessionals = await usersCollection.find().toList();

      String nearestProfessionalEmail = "email";
      double minDifference = double.infinity;

      for (var professional in allProfessionals) {
        double professionalLatitude =
            professional['location']['coordinates'][1];
        double professionalLongitude =
            professional['location']['coordinates'][0];

        double latitudeDifference = (latitude - professionalLatitude).abs();
        double longitudeDifference = (longitude - professionalLongitude).abs();
        double currentDifference = latitudeDifference + longitudeDifference;

        if (currentDifference < minDifference) {
          minDifference = currentDifference;
          nearestProfessionalEmail = professional['email'] as String;
        }
      }

      return nearestProfessionalEmail;
    } catch (e) {
      print('Error while fetching nearest professional: $e');
      return 'email';
    }
  }

  Future<void> _sendEmailToNearestProfessional(Position userLocation,
      String professionalEmail, BuildContext context) async {
    final smtpServer = gmail('email', 'password');

    final latitude = userLocation.latitude;
    final longitude = userLocation.longitude;

    final message = Message()
      ..from = const Address('email', 'Upakrith')
      ..recipients.add(professionalEmail)
      ..subject = 'Emergency: User Needs Assistance'
      ..text =
          'User at location ($latitude, $longitude) needs assistance. Click here for location: [Open in Maps](https://www.google.com/maps/search/?api=1&query=$latitude,$longitude)';

    print('Message content:');
    print('From: ${message.from}');
    print('Recipients: ${message.recipients}');
    print('Subject: ${message.subject}');
    print('Text: ${message.text}');

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Pinged'),
            content: Text(
                'Your location has been sent to the nearest medical professional. The professional will receive an email with a link to open the location in Google Maps.'),
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
    } catch (e) {
      print('Error sending email: $e');
      // Show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send location ping. Please try again.'),
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
}
