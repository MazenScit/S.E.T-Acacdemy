import 'package:flutter/material.dart';
import 'package:setacademyapp/screen/sendmessagesystem/controller/mywidget.dart';

class CheckCode extends StatefulWidget {
  final String code;
  const CheckCode({super.key, required this.code});

  @override
  State<CheckCode> createState() => _CheckCodeState();
}

TextEditingController codecontroller = TextEditingController();

class _CheckCodeState extends State<CheckCode> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Form(
          key: formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios))
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              textform(codecontroller, "enter code", TextInputType.phone,
                  (value) {
                if (!(value!.length == 6)) {
                  return "must be 10 digits";
                }
              }, Icons.numbers),
              SizedBox(
                height: 100,
              ),
              MaterialButton(
                child: Text("check"),
                color: Colors.red,
                onPressed: () {
                  var formdata = formstate.currentState;
                  if (formdata!.validate()) {
                    if (widget.code == codecontroller.text) {
                      print("true");
                    } else {
                      print("false");
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
