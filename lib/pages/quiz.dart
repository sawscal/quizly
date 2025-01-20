import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/final.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = true;
  bool hasError = false;
  int? selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    const url = 'https://api.jsonserve.com/Uw5CrX';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          questions = data['questions'];
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
    }
  }

  void answerQuestion(int scoreIncrement, int index) {
    setState(() {
      score += scoreIncrement;
      selectedOptionIndex = index; 
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null; 
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Final(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (hasError) {
      return const Scaffold(
        body: Center(
            child: Text('Failed to load quiz data. Please try again later.')),
      );
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.purple[200],
        ),
        backgroundColor: Colors.purple[200],
        elevation: 0,
        title: Center(
          child: Text(
            'Question ${currentQuestionIndex + 1}',
            style: GoogleFonts.sahitya(
              fontWeight: FontWeight.w700,
              color: Colors.purple[500],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple[200]!,
              Colors.purple[100]!,
              Colors.purple[50]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${String.fromCharCode(65 + currentQuestionIndex)}. ${question['description']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: question['options'].length,
                            itemBuilder: (context, index) {
                              String optionAlphabet =
                                  String.fromCharCode(65 + index);
                              bool isSelected = selectedOptionIndex == index;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  onPressed: selectedOptionIndex == null
                                      ? () {
                                          final option =
                                              question['options'][index];
                                          answerQuestion(
                                              option['is_correct'] ? 1 : 0,
                                              index);
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? (question['options'][index]
                                                ['is_correct']
                                            ? Colors.green
                                            : Colors.red)
                                        : Colors.white,
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$optionAlphabet. ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            question['options'][index]
                                                ['description'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: isSelected
                                            ? (question['options'][index]
                                                    ['is_correct']
                                                ? Colors.green
                                                : Colors.red)
                                            : Colors.grey[300],
                                        radius: 13,
                                        child: isSelected
                                            ? Icon(
                                                question['options'][index]
                                                        ['is_correct']
                                                    ? Icons.check
                                                    : Icons.close,
                                                color: Colors.white,
                                                size: 15,
                                              )
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: selectedOptionIndex != null ? nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOptionIndex != null
                        ? Colors.purple[400]
                        : Colors.grey[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
