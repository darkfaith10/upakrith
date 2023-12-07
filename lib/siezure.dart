import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SeizureApp extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  SeizureApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help to help in Seizure',
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
                    title: 'Move the person to a safe place.',
                    content:
                        'Loosen any tight clothing around the person \'s neck or waist. This will help them to breathe more easily.',
                  ),

                  // Call emergency services
                  _buildCard(
                    title: 'Place the person on their side.',
                    content:
                        'This will help to keep their airway clear and prevent them from choking on their tongue or vomit.',
                  ),
                  _buildCard(
                    title: 'Do not put anything in the person\'s mouth.',
                    content:
                        'Contrary to popular belief, putting something in the person\'s mouth will not help them and could actually make the situation worse.',
                  ),
                  _buildCard(
                    title: 'Time the seizure',
                    content:
                        'This will help you to determine if the seizure is a medical emergency. A seizure that lasts longer than five minutes is a medical emergency and you should call 108 or your local emergency number.',
                  ),
                  _buildCard(
                    title: 'Remain with the person until the seizure is over.',
                    content:
                        'Talk to the person in a calm voice and reassure them that everything is okay.',
                  ),
                  _buildCard(
                    title: 'After the seizure, help the person to sit up.',
                    content:
                        'Once the seizure is over, help the person to sit up and rest. Offer them a glass of water or juice.',
                  ),
                  _buildCard(
                    title: 'Call the person\'s doctor.',
                    content:
                        'Even if the seizure was brief, it is important to call the person\'s doctor and let them know what happened. The doctor may want to adjust the person\'s medication or make other changes to their treatment plan.',
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
        'images/seizure.jpeg',
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
      'It is important to stay calm and collected when helping someone with an allergic reaction. This will help to keep the person calm and avoid making the situation worse.',
      'Loosen any tight clothing around the person \'s neck or waist. This will help them to breathe more easily.',
      'Contrary to popular belief, putting something in the person\'s mouth will not help them and could actually make the situation worse.',
      'This will help you to determine if the seizure is a medical emergency. A seizure that lasts longer than five minutes is a medical emergency and you should call 108 or your local emergency number.',
      'Reassure the person. Talk to the person in a calm voice and reassure them that everything is okay.',
      'Once the seizure is over, help the person to sit up and rest. Offer them a glass of water or juice.',
      'Even if the seizure was brief, it is important to call the person\'s doctor and let them know what happened. The doctor may want to adjust the person\'s medication or make other changes to their treatment plan.',
    ];
  }
}
