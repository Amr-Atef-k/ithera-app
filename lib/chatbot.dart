import 'dart:async';
import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<Map<String, String>> messages = [];
  bool showQuestions = true;
  bool showWelcomeText = true;

  final Map<String, String> preparedAnswers = {
    'What is depression?': 'Depression is a mental health disorder characterized by persistent feelings of sadness, hopelessness, and a lack of interest or pleasure in activities. It can affect how you think, feel, and handle daily activities, often requiring professional treatment like therapy or medication.',
    'How can I know if I am just sad?': 'Feeling sad is a normal emotion, often triggered by specific events, and typically fades with time. If your sadness persists for weeks, disrupts daily life, or is accompanied by symptoms like fatigue, worthlessness, or loss of interest, it might be depression. Consulting a professional can help clarify.',
    'What is OCD?': 'Obsessive-Compulsive Disorder (OCD) is a mental health condition where individuals experience recurring, unwanted thoughts (obsessions) and engage in repetitive behaviors or mental acts (compulsions) to reduce anxiety caused by these thoughts. Treatment often involves therapy, like CBT, or medication.',
    'How can I handle anxiety?': 'Managing anxiety involves techniques like deep breathing, mindfulness, or progressive muscle relaxation to calm the body. Regular exercise, adequate sleep, and limiting caffeine can help. For persistent anxiety, therapy or professional support may be necessary.',
    'How can I live a healthy mental life?': 'A healthy mental life involves maintaining balance: prioritize self-care, build strong social connections, practice stress management (e.g., meditation or journaling), and seek help when needed. Regular physical activity and a balanced diet also support mental well-being.',
    'What is bipolar disorder?': 'Bipolar disorder is a mental health condition causing extreme mood swings, including manic episodes (high energy, euphoria) and depressive episodes (sadness, low energy). It’s managed with medication, therapy, and lifestyle adjustments under professional guidance.',
    'How can I improve my self-esteem?': 'Improving self-esteem involves challenging negative self-talk, setting achievable goals, and celebrating small successes. Surround yourself with supportive people, practice self-compassion, and consider therapy to address underlying issues.',
    'What are panic attacks?': 'Panic attacks are sudden, intense surges of fear or discomfort, often with physical symptoms like a racing heart, sweating, or shortness of breath. They can be triggered by stress or occur unexpectedly. Breathing exercises and professional help, like CBT, can manage them.',
    'How can I cope with stress?': 'Coping with stress involves identifying triggers and using strategies like time management, exercise, or relaxation techniques (e.g., yoga, meditation). Building a support network and setting boundaries also help. Chronic stress may benefit from professional support.',
    'What is mindfulness?': 'Mindfulness is the practice of staying fully present in the moment, without judgment. It involves focusing on your breath, senses, or thoughts to reduce stress and improve mental clarity. Techniques include meditation, mindful eating, or body scans.'
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/avatar.png'),
                backgroundColor: Colors.grey[200],
              ),
            ),
          ),
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
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0, // Thin border
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: preparedAnswers.keys.map((question) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showQuestions = false;
                              showWelcomeText = false;
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
                ),
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
    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
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