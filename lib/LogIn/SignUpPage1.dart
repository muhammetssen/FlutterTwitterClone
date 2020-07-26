import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:twitter_clone/User/userModel.dart';

import 'SignUpPage2.dart';

class SignUpPage1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

class _SignUp extends State<SignUpPage1> {
  final blueColor = Color(0xff1BA1F3);
  final backgroundColor = Color(0xff000000);
  final inputTextColor = Colors.white;

  double greyFontSize = 18;
  double whiteFontSize = 25;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  bool isNameTooLong = false;
  bool isEmailApproved = true;
  bool isDateApproved = true;

  bool isNameDone = false, isEmailDone = false, isDateDone = false;
  int lengthOfName = 0;

  String pickedDate = '';
  DateTime _dateTime;

  Widget _buildAppbar() {
    return AppBar(
      leading: BackButton(color: blueColor),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.twitter,
            color: blueColor,
          )
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isFormApproved = isNameDone && isEmailDone && isDateDone;

    nameController.addListener(() {
      setState(() {
        lengthOfName = nameController.text.length;
        isNameDone = true;
        if (lengthOfName > 50) {
          lengthOfName = 50 - lengthOfName;
          isNameTooLong = true;
        }
      });
    });

    emailController.addListener(() {
      setState(() {
        isEmailApproved = (EmailValidator.validate(emailController.text));
        isEmailDone = isEmailApproved;
      });
    });
    return Scaffold(
        appBar: _buildAppbar(),
        body: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: backgroundColor)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Create your account",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: whiteFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 45.0,
                        child: TextField(
                          style: TextStyle(
                              fontSize: greyFontSize + 1, color: Colors.white),
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                              color: Color(0xff717576),
                              fontSize: greyFontSize,
                              letterSpacing: 0.5,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        isNameTooLong ? Colors.red : blueColor,
                                    width: 2.0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isNameTooLong
                                        ? Colors.red
                                        : Color(0xff151515),
                                    width: 2.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              lengthOfName.toString(),
                              style: TextStyle(
                                color: Color(0xff717576),
                                fontSize: greyFontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45.0,
                        child: TextField(
                          controller: emailController,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: greyFontSize + 1, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Phone number or email address",
                            hintStyle: TextStyle(
                              color: Color(0xff717576),
                              fontSize: greyFontSize,
                              letterSpacing: 0.5,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isEmailApproved
                                        ? blueColor
                                        : Colors.red,
                                    width: 2.0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isEmailApproved
                                        ? Color(0xff151515)
                                        : Colors.red,
                                    width: 2.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45.0,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController()
                            ..text = pickedDate,
                          onTap: () => pickDate(context),
                          style: TextStyle(
                              fontSize: greyFontSize + 1, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Date of Birth",
                            hintStyle: TextStyle(
                              color: Color(0xff717576),
                              fontSize: greyFontSize,
                              letterSpacing: 0.5,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        isDateApproved ? blueColor : Colors.red,
                                    width: 2.0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isDateApproved
                                        ? Color(0xff151515)
                                        : Colors.red,
                                    width: 2.0)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          // color: Colors.green,
          child: Container(
            color: Color(0xff000000),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      color: blueColor,
                      disabledColor: Color(0xff116191),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide()),
                      onPressed: isFormApproved
                          ? _nextPage
                          : null, //() => print("pressed"),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ));
  }

  void _nextPage() {
    print("Form is approved, next");
    User createdUser = User(
        name: nameController.text,
        email: emailController.text,
        dateOfBirth: dateOfBirthController.text);
  
    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpPage2(user : createdUser)));
    
  }
  

  pickDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
            firstDate: DateTime(1900),
            lastDate: DateTime(DateTime.now().year + 1))
        .then((date) => {
              setState(() {
                _dateTime = date;
                pickedDate = '${date.day}-${date.month}-${date.year}';
                isDateApproved = true;
                if (date.year > DateTime.now().year - 18) {
                  isDateApproved = false;
                }
                isDateDone = isDateApproved;
              })
            });
  }
}
