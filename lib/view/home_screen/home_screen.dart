import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:quiz/utils/color_constants.dart';
import 'package:quiz/view/category_screen/category_screen.dart';
import 'package:quiz/view/home_screen/widget/option_card.dart';
import 'package:quiz/view/result_screen/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.qA,
    required this.catIndex,
  });
  final List? qA;
  final int catIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentQstnIndex = 0;
  int? selectedIndex;
  int rightAnswerCount = 0;
  int skipCount = 0;
  int wrongcount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryScreen(),
              ),
              (route) => false,
            );
          },
          icon: Icon(
            Icons.cancel_outlined,
            size: 30,
            color: ColorConstants.maingrey,
          ),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.maingrey),
              borderRadius: BorderRadius.circular(20)),
          child: LinearPercentIndicator(
            barRadius: Radius.circular(5),
            lineHeight: 10,
            linearStrokeCap: LinearStrokeCap.round,
            trailing: Text(
              "${currentQstnIndex + 1}/${widget.qA!.length}",
              style: TextStyle(color: ColorConstants.blue, fontSize: 18),
            ),
            percent: (currentQstnIndex + 1) / widget.qA!.length,
            backgroundColor: ColorConstants.mainwhite,
            progressColor: ColorConstants.amber,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: 500,
                ),
                Positioned(
                  top: 55,
                  child: Container(
                    height: 300,
                    width: 380,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstants.maingrey.withOpacity(0.5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            widget.qA![currentQstnIndex]['question'],
                            style: TextStyle(
                                color: ColorConstants.mainwhite, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 165,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.mainBlack),
                      child: CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        lineWidth: 10,
                        radius: 40,
                        progressColor: ColorConstants.blue,
                        backgroundColor: ColorConstants.mainwhite,
                        center: Text(
                          "${currentQstnIndex + 1}",
                          style: TextStyle(
                              color: ColorConstants.mainwhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        percent: (currentQstnIndex + 1) / widget.qA!.length,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //option card
            Column(
              children: List.generate(
                4,
                (index) {
                  List ansOption = widget.qA![currentQstnIndex]['options'];
                  return OptionCard(
                    options: ansOption[index],
                    borderColor: getColor(index),
                    optionIcon: getIcon(index),
                    onTap: () {
                      if (selectedIndex == null) {
                        setState(() {
                          selectedIndex = index;
                          if (selectedIndex ==
                              widget.qA![currentQstnIndex]['answerIndex']) {
                            rightAnswerCount++;
                            print(rightAnswerCount);
                          } else {
                            wrongcount++;
                            print(wrongcount);
                          }
                        });
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorConstants.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  if (selectedIndex != null) {
                    if (currentQstnIndex < widget.qA!.length - 1) {
                      currentQstnIndex++;
                      selectedIndex = null;
                      setState(() {});
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              //index from gridview of category screen passed to result screen
                              listIndex: widget.catIndex,
                              qstn: widget.qA!.length,
                              skipAnswer: skipCount,
                              wrongAnswers: wrongcount,
                              rightAnswerCount: rightAnswerCount,
                            ),
                          ));
                    }
                  } else {
                    if (currentQstnIndex < widget.qA!.length - 1) {
                      currentQstnIndex++;
                      skipCount++;
                      selectedIndex = null;
                      setState(() {});
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              //index from gridview of category screen passed to result screen
                              listIndex: widget.catIndex,
                              qstn: widget.qA!.length,
                              skipAnswer: skipCount + 1,
                              wrongAnswers: wrongcount,
                              rightAnswerCount: rightAnswerCount,
                            ),
                          ));
                    }
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.mainwhite,
                      fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getIcon(int index) {
    if (selectedIndex != null) {
      if (selectedIndex == widget.qA![currentQstnIndex]['answerIndex'] &&
          selectedIndex == index) {
        return Icon(
          Icons.check_circle_outline,
          color: ColorConstants.green,
        );
      } else if (selectedIndex != widget.qA![currentQstnIndex]['answerIndex'] &&
          selectedIndex == index) {
        return Icon(
          Icons.cancel_outlined,
          color: ColorConstants.red,
        );
      } else if (widget.qA![currentQstnIndex]['answerIndex'] == index) {
        return Icon(
          Icons.check_circle_outline,
          color: ColorConstants.green,
        );
      }
    }
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorConstants.mainwhite)),
    );
  }

  Color getColor(int index) {
    if (selectedIndex != null) {
      if (selectedIndex == widget.qA![currentQstnIndex]['answerIndex'] &&
          selectedIndex == index) {
        return ColorConstants.green;
      } else if (selectedIndex != widget.qA![currentQstnIndex]['answerIndex'] &&
          selectedIndex == index) {
        return ColorConstants.red;
      } else if (widget.qA![currentQstnIndex]['answerIndex'] == index) {
        return ColorConstants.green;
      }
    }

    return ColorConstants.maingrey;
  }
}
