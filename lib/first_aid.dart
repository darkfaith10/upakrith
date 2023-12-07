import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FirstAidApp extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  FirstAidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'First Aid',
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
            _buildCPRAnimation(),

            // Steps
            Expanded(
              child: ListView(
                children: [
                  _buildCard(
                    title: 'Assess Danger',
                    content:
                        'If a person has been harmed during an accident, the first thing you have to do is check for danger.',
                  ),

                  _buildCard(
                    title: 'Response',
                    content:
                        'Following a thorough danger assessment, you’ll need to assess the responsiveness of the injured individual. Are they conscious? Are they capable of answering questions and cooperating?',
                  ),

                  // Call emergency services
                  _buildCard(
                    title: 'Call 108 or Your Local Emergency Number',
                    content:
                        'Calling 108 on your phone is the next essential step.',
                  ),
                  _buildCard(
                    title: 'Airway',
                    content:
                        'Check the injured person’s breathing and make sure their airways are clear.',
                  ),
                  _buildCard(
                    title: 'Breathing',
                    content:
                        'If a person is breathing, you can skip the subsequent steps. In the event of them being unconscious, check for chest movements and if they’re breathing, turn them on a side and align the head, neck and spine. Wait for medical assistance to arrive.',
                  ),
                  _buildCard(
                    title: 'CPR',
                    content:
                        'When a person isn’t breathing, you’ll have to administer CPR',
                  ),
                  _buildCard(
                    title: 'Defibrillator',
                    content:
                        'An automated external defibrillator (AED) is often available in public areas and can be used by people who have the right kind of training.',
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
        'images/firstaid.gif',
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
      'If a person has been harmed during an accident, the first thing you have to do is check for danger.',
      'Following a thorough danger assessment, you’ll need to assess the responsiveness of the injured individual. Are they conscious? Are they capable of answering questions and cooperating?',
      'Calling 108 on your phone is the next essential step.',
      'Check the injured person’s breathing and make sure their airways are clear.',
      'If a person is breathing, you can skip the subsequent steps. In the event of them being unconscious, check for chest movements and if they’re breathing, turn them on a side and align the head, neck and spine. Wait for medical assistance to arrive. When a person isn’t breathing, you’ll have to administer CPR',
    ];
  }
}
