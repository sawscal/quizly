import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/pages/home.dart';
import 'package:quiz_app/pages/quiz.dart';

class Final extends StatelessWidget {
  final int score;
  final int total;

  const Final({Key? key, required this.score, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
           color: Colors.purple[200],
        ),
       backgroundColor: Colors.purple[200],
        elevation: 0,
         leading: IconButton(
         icon: const Icon(Icons.arrow_back,
         color: Colors.white,),
          onPressed: () {
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Qhome()),
      );
    },
  ),
       title: Center(
            child: Text(
              'Quiz Summary',
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:EdgeInsets.all(90) ,
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.purple.shade100.withOpacity(0.3),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white.withOpacity(0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Score',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.purple[800],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$score / $total',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: Colors.purple.withOpacity(0.7),
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'You answered ${(score / total * 100).toStringAsFixed(1)}% of the questions correctly!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Quiz()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[400],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Restart Quiz',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
