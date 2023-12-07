import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AllergyReactionApp extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  AllergyReactionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help an Allergic Reaction',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () => _readOutAllData(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CPR Animation
            _buildCPRAnimation(),

            // Steps
            Expanded(
              child: ListView(
                children: [
                  // Stay calm
                  _buildCard(
                    title: 'Stay Calm',
                    content:
                        'It is important to stay calm and collected when helping someone with an allergic reaction. This will help to keep the person calm and avoid making the situation worse.',
                  ),

                  // Identify the allergen
                  _buildCard(
                    title: 'Identify the Allergen',
                    content:
                        'If possible, try to identify the allergen that caused the reaction. This will help the person\'s doctor to treat the reaction and prevent future reactions.',
                  ),

                  // Call emergency services
                  _buildCard(
                    title: 'Call 108 or Your Local Emergency Number',
                    content:
                        'A severe allergic reaction, also known as anaphylaxis, is a medical emergency and you should call for help immediately.',
                  ),
                  _buildCard(
                    title: 'Administer epinephrine',
                    content:
                        'If the person has an epinephrine auto-injector, such as an EpiPen or Anapen, administer the injection as instructed.',
                  ),
                  _buildCard(
                    title: 'Reassure the person.',
                    content:
                        'Talk to the person in a calm voice and reassure them that everything is okay.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCPRAnimation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      height: 200.0, // Adjust the height as needed
      child: Image.asset(
        'images/epipen.webp',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCard({required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.redAccent),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _readOutAllData() async {
    for (var cardData in _cardDataList) {
      await flutterTts.speak(cardData);
    }
  }

  List<String> get _cardDataList {
    return [
      'Stay Calm. It is important to stay calm and collected when helping someone with an allergic reaction. This will help to keep the person calm and avoid making the situation worse.',
      'Identify the Allergen. If possible, try to identify the allergen that caused the reaction. This will help the person\'s doctor to treat the reaction and prevent future reactions.',
      'Call 108 or Your Local Emergency Number. A severe allergic reaction, also known as anaphylaxis, is a medical emergency and you should call for help immediately.',
      'Administer epinephrine. If the person has an epinephrine auto-injector, such as an EpiPen or Anapen, administer the injection as instructed.',
      'Reassure the person. Talk to the person in a calm voice and reassure them that everything is okay.',
    ];
  }
}
