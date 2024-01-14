import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  double sizeout = 50;
  Color clr = Colors.grey.shade500;

  buttonpressed(String buttonText) {
    if (buttonText == 'C') {
      input = '';
      output = '';
    } else if (buttonText == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(userInput);
          ContextModel cm = ContextModel();
          var finalval = '${exp.evaluate(EvaluationType.REAL, cm)}';

          output = finalval.toString();
        } catch (e) {
          output = 'Error';
        }
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        sizeout = 70;
        clr = Colors.white;
      }
    } else {
      input = input + buttonText;
      hideInput = false;
      sizeout = 50;
      clr = Colors.grey.shade500;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Calculator",
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          hideInput ? '' : input,
                          style: const TextStyle(
                              fontSize: 70, color: Colors.white),
                        ),
                        Text(
                          output,
                          style: TextStyle(fontSize: sizeout, color: clr),
                        ),
                      ])),
            ),
          ),
          Row(
            children: [
              buildbutton("7", Colors.grey.shade800),
              buildbutton("8", Colors.grey.shade800),
              buildbutton("9", Colors.grey.shade800),
              buildbutton("/", Colors.amber.shade700),
            ],
          ),
          Row(
            children: [
              buildbutton("4", Colors.grey.shade800),
              buildbutton("5", Colors.grey.shade800),
              buildbutton("6", Colors.grey.shade800),
              buildbutton("x", Colors.amber.shade700)
            ],
          ),
          Row(
            children: [
              buildbutton("1", Colors.grey.shade800),
              buildbutton("2", Colors.grey.shade800),
              buildbutton("3", Colors.grey.shade800),
              buildbutton("-", Colors.amber.shade700)
            ],
          ),
          Row(
            children: [
              buildbutton("C", Colors.amber.shade700),
              buildbutton("0", Colors.grey.shade800),
              buildbutton("=", Colors.grey.shade800),
              buildbutton("+", Colors.amber.shade700)
            ],
          ),
          // ]
          // ),
          // ),
        ],
      ),
    );
  }

  Widget buildbutton(String buttontext, Color btncolor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            buttonpressed(buttontext);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: btncolor,
              elevation: 0.0,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(30)),
          child: Text(
            buttontext,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
