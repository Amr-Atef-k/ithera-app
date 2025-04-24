import 'dart:async';
import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<Map<String, String>> messages = [];
  bool showQuestions = true;
  bool showWelcomeText = true; // State variable for welcome text

  final Map<String, String> preparedAnswers = {
    'How are you?': 'I am doing great! How can I assist you today?',
    'What is your name?': 'I am iThera, your mental health assistant.',
    'What do you do?': 'I help you assess your mental state with questions and AI-powered tests.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          // Avatar with less thick border
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black, // Black border
                  width: 3.0, // Less thick border
                ),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/avatar.png'), // Replace with your image path
                backgroundColor: Colors.grey[200], // Fallback color
              ),
            ),
          ),
          // Welcome text, shown only when showWelcomeText is true
          if (showWelcomeText)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Welcome, how can I help you today?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUserMessage = messages[index]['isUser'] == 'true';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: isUserMessage
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isUserMessage ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AnimatedText(
                          key: ValueKey('${messages[index]['text']}_$index'),
                          text: messages[index]['text']!,
                          isAnswer: !isUserMessage && index == 0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (showQuestions)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: preparedAnswers.keys.map((question) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showQuestions = false;
                        showWelcomeText = false; // Permanently hide welcome text
                        messages.insert(0, {'text': question, 'isUser': 'true'});
                      });
                      Future.delayed(Duration(milliseconds: 500), () {
                        setState(() {
                          messages.insert(0, {
                            'text': preparedAnswers[question]!,
                            'isUser': 'false'
                          });
                        });
                        Future.delayed(Duration(milliseconds: 2000), () {
                          setState(() {
                            showQuestions = true;
                          });
                        });
                      });
                    },
                    child: Text(question),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  final String text;
  final bool isAnswer;

  AnimatedText({required this.text, required this.isAnswer, Key? key})
      : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  String displayText = '';
  int textIndex = 0;
  Timer? _timer;
  bool hasAnimated = false;

  @override
  void initState() {
    super.initState();
    if (widget.isAnswer && !hasAnimated) {
      _animateText();
    } else {
      displayText = widget.text;
    }
  }

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      setState(() {
        displayText = '';
        textIndex = 0;
        hasAnimated = false;
      });
      _timer?.cancel();
      if (widget.isAnswer && !hasAnimated) {
        _animateText();
      } else {
        setState(() {
          displayText = widget.text;
        });
      }
    }
  }

  void _animateText() {
    hasAnimated = true;
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (textIndex < widget.text.length) {
        setState(() {
          displayText += widget.text[textIndex];
          textIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}