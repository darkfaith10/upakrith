import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CPRApp extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  CPRApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perform CPR',
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
                    title: 'Check the scene for safety',
                    content:
                        'Make sure the area is safe for you to perform CPR. This means checking for hazards such as traffic, fire, or other people who may be injured',
                  ),
                  _buildCard(
                    title: 'Call 108 or your local emergency number',
                    content:
                        'This is the most important step. Even if you are trained in CPR, it is important to call for help as soon as possible.',
                  ),
                  _buildCard(
                    title: 'Check for responsiveness',
                    content:
                        'Gently tap the person on the shoulder and shout, \"Are you okay?" If the person does not respond, go to the next step.',
                  ),
                  _buildCard(
                    title: 'Check for breathing',
                    content:
                        'Look for the person\'s chest to rise and fall. Place your ear next to their mouth and nose and listen for breathing. You can also place your hand on their chest to feel for breaths. If the person is not breathing, go to the next step.',
                  ),
                  _buildCard(
                    title: 'Start chest compressions',
                    content:
                        'Kneel beside the person and place the heel of your hand on the center of their chest, just below the nipples. Place your other hand on top of your first hand and interlock your fingers. Straighten your arms and press down on the chest using your body weight. Press down hard and fast, about 2 inches deep, at a rate of 100 to 120 compressions per minute.',
                  ),
                  _buildCard(
                    title: 'Give rescue breaths',
                    content:
                        'After every 30 chest compressions, give the person two rescue breaths. Pinch the person \'s nose closed and seal your mouth over theirs. Blow into their mouth for about 1 second, making sure their chest rises.',
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
        'images/cprimage.gif',
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
      'This is the most important step Even if you are trained in CPR, it is important to call for help as soon as possible',
      'Gently tap the person on the shoulder and shout, \"Are you okay" If the person does not respond, go to the next step',
      'Look for the person\'s chest to rise and fall Place your ear next to their mouth and nose and listen for breathing You can also place your hand on their chest to feel for breaths If the person is not breathing, go to the next step',
      'Kneel beside the person and place the heel of your hand on the center of their chest, just below the nipples. Place your other hand on top of your first hand and interlock your fingers Straighten your arms and press down on the chest using your body weight Press down hard and fast, about 2 inches deep, at a rate of 100 to 120 compressions per minute',
      'After every 30 chest compressions,give the person two rescue breaths. Pinch the person \'s nose closed and seal your mouth over theirs. Blow into their mouth for about 1 second, making sure their chest rises.',
    ];
  }
}
