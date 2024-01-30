import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/common/file_view.dart';
import 'package:wype_user/common/primary_button.dart';
import 'package:wype_user/constants.dart';
import 'package:wype_user/services/firebase_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignIn = true;
  bool isMale = true;
  bool isAgree = false;
  bool isLoading = false;
  FirebaseService firebaseService = FirebaseService();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height(context) * 0.06,
            ),
            Image(
              image: AssetImage('assets/images/logo.png'),
              height: height(context) * 0.08,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: height(context) * 0.05,
            ),
            Row(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => setState(() {
                    isSignIn = true;
                  }),
                  child: Column(
                    children: [
                      Text(
                        "Sign In",
                        style: GoogleFonts.readexPro(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      4.height,
                      isSignIn
                          ? Container(
                              height: 4,
                              width: width(context) * 0.2,
                              color: lightGradient,
                            )
                          : Container(
                              height: 4,
                            ),
                    ],
                  ),
                ),
                30.width,
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => setState(() {
                    isSignIn = false;
                  }),
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: GoogleFonts.readexPro(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      4.height,
                      isSignIn
                          ? Container(
                              height: 4,
                            )
                          : Container(
                              height: 4,
                              width: width(context) * 0.2,
                              color: lightGradient,
                            ),
                    ],
                  ),
                ),
              ],
            ),
            40.height,
            isSignIn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.readexPro(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: darkGradient),
                      ),
                      40.height,
                      AppTextField(
                        controller: emailCont,
                        onChanged: (val) => setState(() {}),
                        textStyle: GoogleFonts.readexPro(),
                        textFieldType: TextFieldType.NUMBER,
                        maxLength: 10,
                        decoration:
                            inputDecoration(context, labelText: "Mobile Number"),
                      ),
                      15.height,
                      AppTextField(
                        isPassword: true,
                        controller: passCont,
                        onChanged: (val) => setState(() {}),
                        textStyle: GoogleFonts.readexPro(),
                        textFieldType: TextFieldType.EMAIL,
                        
                        maxLength: 10,
                        decoration:
                            inputDecoration(context, labelText: "Password"),
                      ),
                      50.height,
                      Align(
                        alignment: Alignment.center,
                        child: PrimaryButton(
                            text: isLoading ? loaderText : "Login",
                            onTap: () async {
                              if (emailCont.text.isEmpty ||
                                  passCont.text.isEmpty) {
                                toast("Enter valid credentials");
                              } else {
                                hideKeyboard(context);
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await firebaseService.login(
                                      context,
                                      false,
                                      null,
                                      emailCont.text,
                                      null,
                                      passCont.text);
                                } catch (e) {
                                  toast("Invalid credentials");
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            }),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      10.height,
                      AppTextField(
                        textStyle: GoogleFonts.readexPro(),
                        textFieldType: TextFieldType.EMAIL,
                        controller: nameCont,
                        decoration:
                            inputDecoration(context, labelText: "Full Name"),
                      ),
                      15.height,
                      AppTextField(
                        textStyle: GoogleFonts.readexPro(),
                        textFieldType: TextFieldType.NUMBER,
                        controller: emailCont,
                        maxLength: 10,
                        decoration: inputDecoration(context,
                            labelText: "Mobile Number"),
                      ),
                      15.height,
                         AppTextField(
                        textStyle: GoogleFonts.readexPro(),
                        textFieldType: TextFieldType.EMAIL,
                        controller: passCont,
                        isPassword: true,
                        maxLength: 10,
                        decoration: inputDecoration(context,
                            labelText: "Password"),
                      ),
                      30.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => setState(() {
                              isMale = true;
                            }),
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Icon(
                                !isMale
                                    ? FontAwesomeIcons.circle
                                    : FontAwesomeIcons.circleCheck,
                                color: darkGradient,
                              ),
                            ),
                          ),
                          10.width,
                          Text(
                            "Male",
                            style: GoogleFonts.readexPro(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          50.width,
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => setState(() {
                              isMale = false;
                            }),
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Icon(
                                isMale
                                    ? FontAwesomeIcons.circle
                                    : FontAwesomeIcons.circleCheck,
                                color: darkGradient,
                              ),
                            ),
                          ),
                          10.width,
                          Text(
                            "Female",
                            style: GoogleFonts.readexPro(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(context) * 0.1,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => setState(() {
                          isAgree = !isAgree;
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(
                                isAgree
                                    ? FontAwesomeIcons.circleCheck
                                    : FontAwesomeIcons.circle,
                                color: darkGradient,
                              ),
                            ),
                            10.width,
                            InkWell(
                              onTap: () => navigation(
                                  context,
                                  FileViewPage(
                                      assetPath: 'assets/docs/t&c.pdf'),
                                  true),
                              child: Text(
                                "I agree to Terms & Condition",
                                style: GoogleFonts.readexPro(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      30.height,
                      Align(
                        alignment: Alignment.center,
                        child: PrimaryButton(
                            text: isLoading ? loaderText : "Sign Up",
                            onTap: () async {
                              if (nameCont.text.isEmpty ||
                                  emailCont.text.isEmpty ||
                                  passCont.text.isEmpty) {
                                toast("Enter valid inputs");
                              } else if (!isAgree) {
                                toast("Please check T&C");
                              } else {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await firebaseService.login(
                                      context,
                                      true,
                                      nameCont.text,
                                      emailCont.text,
                                      isMale ? "Male" : "Female",
                                      passCont.text);

                                  setState(() {
                                    isLoading = false;
                                  });
                                } catch (e) {
                                  toast(e.toString());
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            }),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
