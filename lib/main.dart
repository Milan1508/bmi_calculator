// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiCalculator(),
    );
  }
}

// Let's start by creating a new Stateful widget
class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
// Here Im going to declare a variable for our custom radio button
  int currentindex = 0;
  String result = "";
  // declaring the input Controller to get the input value
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      // First Ill create Simple app bar
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xfffafafa),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ))
        ],
      ),
      // now creating body of the app
      // we will wrap all the body inside a Single Scroll Child
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                radioButton("Man", Colors.blue, 0),
                radioButton("Woman", Colors.pink, 1),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            // now creating the input form
            Text(
              "Your height in Cm : ",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              // adding the controller
              controller: heightController,

              decoration: InputDecoration(
                  hintText: "Your height in Cm",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),

            // For weight also same thing copy paste here
            Text(
              "Your Weight in Kg : ",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: weightController,
              decoration: InputDecoration(
                  hintText: "Your weight in Kg",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),

            // Making Calculation Button
            Container(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.blue)),
                  onPressed: () {
                    double height = double.parse(heightController.value.text);
                    double weight = double.parse(weightController.value.text);
                    calculateBmi(height, weight);
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white),
                  ),
                )),

            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              child: Text(
                "Your BMI is :",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              width: double.infinity,
              child: Text(
                "$result",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )),
    ));
  }

  void calculateBmi(double height, double weight) {
    double finalresult =
        weight / (height * height / 10000); // cm to metre conversion
    String bmi = finalresult.toStringAsFixed(2);
    setState(() {
      result = bmi;
    });
  }

// and here i'm going to declare a function to change the index on button pressed
  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  // Now i will create a new custom widget
  Widget radioButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
      // adding some margins to the container
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      height: 80.0,
      child: TextButton(
        onPressed: () {
          // when we click the button the current index will have the value of the buttons index value
          changeIndex(index);
        },
        //Now I want the color of my button change in function of its selected or not
        //this line means if the current index is equal to the button index then put the color
        // the main color that we will define otherwise make it grey
        style: ButtonStyle(
            backgroundColor: currentindex == index
                ? MaterialStatePropertyAll<Color>(color)
                : MaterialStatePropertyAll<Color>(Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)))),

        child: Text(
          value,
          style: TextStyle(
              color: currentindex == index ? Colors.white : color,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        //
      ),
    ));
  }
}
