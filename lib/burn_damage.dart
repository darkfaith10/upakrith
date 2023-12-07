import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BurnDamgeApp extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  BurnDamgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Burn Damage',
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
                    title: 'Cool the burn',
                    content:
                        'Hold the area under cool (not cold) running water for about 10 minutes. If the burn is on the face, apply a cool, wet cloth until the pain eases.',
                  ),

                  // Identify the allergen
                  _buildCard(
                    title:
                        'Remove rings or other tight items from the burned area',
                    content:
                        'Try to do this quickly and gently, before the area swells.',
                  ),

                  // Call emergency services
                  _buildCard(
                    title: 'Don\'t break blisters',
                    content:
                        'Blisters help protect against infection. If a blister does break, gently clean the area with water and apply an antibiotic ointment.',
                  ),
                  _buildCard(
                    title: 'Apply lotion',
                    content:
                        'After the burn is cooled, apply a lotion, such as one with aloe vera or cocoa butter. This helps prevent drying and provides relief',
                  ),
                  _buildCard(
                    title: 'Bandage the burn',
                    content:
                        'Cover the burn with a clean bandage. Wrap it loosely to avoid putting pressure on burned skin. Bandaging keeps air off the area, reduces pain and protects blistered skin.',
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
        'images/burn.webp',
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
      'Cool the burn. Hold the area under cool (not cold) running water for about 10 minutes. If the burn is on the face, apply a cool, wet cloth until the pain eases.',
      'Remove rings or other tight items from the burned area. Try to do this quickly and gently, before the area swells.',
      'Don\'t break blisters. Blisters help protect against infection. If a blister does break, gently clean the area with water and apply an antibiotic ointment.',
      'Apply lotion. After the burn is cooled, apply a lotion, such as one with aloe vera or cocoa butter. This helps prevent drying and provides relief',
      'Bandage the burn. Cover the burn with a clean bandage. Wrap it loosely to avoid putting pressure on burned skin. Bandaging keeps air off the area, reduces pain and protects blistered skin.',
    ];
  }
}
