import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganDonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Organ Donation',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOrganDonationImage(),
            _buildInformationText(),
            _buildRegisterButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganDonationImage() {
    return Container(
      height: 180,
      margin: EdgeInsets.only(bottom: 100.0, top: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        'images/organdonation.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInformationText() {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0, top: 0.0),
      child: Text(
        'Organ donation is a selfless way to give back to others. Your decision to become an organ donor can save lives. Register today!',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateToRegistration(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text('Register for Organ Donation'),
    );
  }

  void _navigateToRegistration(BuildContext context) async {
    final registrationUrl = 'https://notto.mohfw.gov.in/';

    if (await canLaunch(registrationUrl)) {
      await launch(registrationUrl);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Could not launch the registration URL.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
