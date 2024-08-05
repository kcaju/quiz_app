import 'package:flutter/material.dart';
import 'package:quiz/dummy_db.dart';
import 'package:quiz/utils/color_constants.dart';
import 'package:quiz/utils/image_constants.dart';
import 'package:quiz/view/category_screen/tabs/category_tab.dart';
import 'package:quiz/view/home_screen/home_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi,John",
                          style: TextStyle(
                              color: ColorConstants.mainwhite,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Let's make this day productive",
                          style: TextStyle(
                            color: ColorConstants.mainwhite,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(ImageConstants.PROFILE))),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImageConstants.TROPHY,
                            height: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ranking",
                                style: TextStyle(
                                  color: ColorConstants.mainwhite,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "384",
                                style: TextStyle(
                                    color: ColorConstants.blue,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 60,
                        child: VerticalDivider(
                          thickness: 2,
                          color: ColorConstants.maingrey,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImageConstants.COIN,
                            height: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Points",
                                style: TextStyle(
                                  color: ColorConstants.mainwhite,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "1209",
                                style: TextStyle(
                                    color: ColorConstants.blue,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                    color: ColorConstants.maingrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Let's Play",
                  style: TextStyle(
                      color: ColorConstants.mainwhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: DummyDb.question.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 280,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                qA: DummyDb.question[index],
                                catIndex: index, //taking index of gridview
                              ),
                            ));
                      },
                      child: CategoryTab(
                        url: DummyDb.category[index]['url'],
                        title: DummyDb.category[index]['title'],
                        qno: DummyDb.category[index]['qno'],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
