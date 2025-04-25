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

  // List of questions with their answers and scores
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'How do you currently feel in terms of your mood?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you find it hard to enjoy things you used to love?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you feel constantly anxious or tense?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you have difficulty falling or staying asleep?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you feel tired or exhausted even after sleeping?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you find it hard to concentrate or think clearly?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you feel hopeless or like life has no meaning?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you have negative thoughts about yourself or feel guilty?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Do you feel disconnected or isolated from others?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
    {
      'question': 'Have you experienced changes in appetite or weight?',
      'answers': [
        {'text': 'Rarely', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Often', 'score': 3},
        {'text': 'Always', 'score': 4},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the list to store selected answers for each question
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _initializeCamera();
  }

  // Initializes the front-facing camera for emotion detection
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

  // Calculates the total score and navigates to the report screen
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

  // Shows a confirmation dialog when the user attempts to exit the test
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

  // Shows an alert if the user tries to proceed without selecting an answer
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
    // Clean up the camera controller to free resources
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

            // Camera Preview for emotion detection
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

            // Placeholder for emotion detection result
            Text(
              'Emotion: ______',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),

            SizedBox(height: 20),

            // Question Box with question number
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFD3D7DA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_currentQuestionIndex + 1}. ${currentQuestion['question']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20),

            // Answer Buttons
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

            // Navigation Buttons for moving between questions or submitting
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
                Spacer(), // Push "Next" or "Submit" to the right
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