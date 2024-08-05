import 'package:flutter/material.dart';
import 'package:quiz/dummy_db.dart';
import 'package:quiz/utils/color_constants.dart';
import 'package:quiz/view/home_screen/home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.rightAnswerCount,
      required this.wrongAnswers,
      this.skipAnswer,
      required this.qstn,
      required this.listIndex});
  final int rightAnswerCount;
  final int wrongAnswers;
  final int? skipAnswer;
  final int qstn;
  final int listIndex;

  @override
  Widget build(BuildContext context) {
    double percentage = rightAnswerCount * 100 / qstn;

    return Scaffold(
      backgroundColor: ColorConstants.mainBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "congrats",
              style: TextStyle(
                fontSize: 25,
                color: ColorConstants.mainwhite,
              ),
            ),
            Text(
              "$percentage%",
              style: TextStyle(
                  fontSize: 30,
                  color: ColorConstants.green,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Correct Answers: $rightAnswerCount",
              style: TextStyle(
                  fontSize: 15,
                  color: ColorConstants.mainwhite,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Wrong Answers: $wrongAnswers",
              style: TextStyle(
                  fontSize: 15,
                  color: ColorConstants.mainwhite,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Skipped Questions: $skipAnswer",
              style: TextStyle(
                  fontSize: 15,
                  color: ColorConstants.mainwhite,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      qA: DummyDb.question[listIndex],
                      catIndex: listIndex,
                    ),
                  ),
                );
              },
              child: Container(
                child: Center(
                  child: Text(
                    "Restart",
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.mainwhite,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: ColorConstants.orange,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 2, color: ColorConstants.mainwhite)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
