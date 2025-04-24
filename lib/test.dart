import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'report.dart';
import 'home.dart';

class TestPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  TestPage({required this.cameras});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int?> _selectedAnswers = [];

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'How are you feeling today?',
      'answers': [
        {'text': 'Great', 'score': 3},
        {'text': 'Good', 'score': 2},
        {'text': 'Okay', 'score': 1},
        {'text': 'Bad', 'score': 0},
      ],
    },
    {
      'question': 'Do you enjoy your daily activities?',
      'answers': [
        {'text': 'Always', 'score': 3},
        {'text': 'Often', 'score': 2},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Never', 'score': 0},
      ],
    },
    {
      'question': 'How often do you feel anxious?',
      'answers': [
        {'text': 'Never', 'score': 3},
        {'text': 'Rarely', 'score': 2},
        {'text': 'Often', 'score': 1},
        {'text': 'Always', 'score': 0},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _initializeCamera();
  }

  void _initializeCamera() async {
    _cameraController = CameraController(
      widget.cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front),
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();

    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _submitAnswers() {
    _score = 0;
    for (int i = 0; i < _selectedAnswers.length; i++) {
      final selected = _selectedAnswers[i];
      if (selected != null) {
        _score += (_questions[i]['answers'][selected]['score'] as int);
      }
    }
    _cameraController.dispose();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReportScreen(score: _score),
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit Test"),
        content: Text("Are you sure you want to exit the test?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              _cameraController.dispose();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
              );
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _showNoAnswerAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("No Answer Selected"),
        content: Text("Please select an answer to continue."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Color(0xFFFAFBFC),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: _showExitConfirmation,
              ),
            ),

            // Camera Preview
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CameraPreview(_cameraController),
              ),
            ),

            SizedBox(height: 20),

            // Emotion placeholder
            Text(
              'Emotion: ______',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),

            SizedBox(height: 20),

            // Question Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFD3D7DA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentQuestion['question'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20),

            // Answers Column
            Column(
              children: List.generate(currentQuestion['answers'].length, (index) {
                final answer = currentQuestion['answers'][index];
                final isSelected = _selectedAnswers[_currentQuestionIndex] == index;
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedAnswers[_currentQuestionIndex] = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.lightGreen : Color(0xFFD3D7DA),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      answer['text'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 20),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
              children: [
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
                      });
                    },
                    child: Text("Previous"),
                  ),
                Spacer(), // Push "Next" to the right
                if (_currentQuestionIndex < _questions.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedAnswers[_currentQuestionIndex] == null) {
                        _showNoAnswerAlert(); // Show alert if no answer selected
                      } else {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      }
                    },
                    child: Text("Next"),
                  ),
                if (_currentQuestionIndex == _questions.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedAnswers[_currentQuestionIndex] == null) {
                        _showNoAnswerAlert(); // Show alert if no answer selected
                      } else {
                        _submitAnswers();
                      }
                    },
                    child: Text("Submit"),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
