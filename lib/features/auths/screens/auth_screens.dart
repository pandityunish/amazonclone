import 'package:amazon_clone/common/widgets/costum_buttom.dart';
import 'package:amazon_clone/common/widgets/costum_textfield.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/features/auths/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth { signin, singup }

class AuthScreen extends StatefulWidget {
  static const String routename = "/auth-screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final AuthService authServices = AuthService();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }

  final sigingloblekey = GlobalKey<FormState>();
  final signupgloblekey = GlobalKey<FormState>();
  void singupuser() {
    authServices.signUpUser(
        context: context,
        email: emailcontroller.text,
        name: namecontroller.text,
        password: passwordcontroller.text);
  }

  void signinuser() {
    authServices.signInUser(
        context: context,
        email: emailcontroller.text,
        password: passwordcontroller.text);
  }

  Auth? auth = Auth.singup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
            ListTile(
              tileColor: auth == Auth.singup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.singup,
                groupValue: auth,
                onChanged: (Auth? value) {
                  setState(() {
                    auth = value!;
                  });
                },
              ),
            ),
            if (auth == Auth.singup)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                    key: signupgloblekey,
                    child: Column(
                      children: [
                        CostumFormfield(
                          controller: namecontroller,
                          hinttext: "Name",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CostumFormfield(
                          controller: emailcontroller,
                          hinttext: "Email",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CostumFormfield(
                          controller: passwordcontroller,
                          hinttext: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Costumbottom(
                            text: "Sign Up",
                            onPressed: () {
                              if (signupgloblekey.currentState!.validate()) {
                                singupuser();
                              }
                            })
                      ],
                    )),
              ),
            ListTile(
              tileColor: auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign-In.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: auth,
                onChanged: (value) {
                  setState(() {
                    auth = value as Auth?;
                  });
                },
              ),
            ),
            if (auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                    key: sigingloblekey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CostumFormfield(
                          controller: emailcontroller,
                          hinttext: "Email",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CostumFormfield(
                          controller: passwordcontroller,
                          hinttext: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Costumbottom(
                            text: "Sign In",
                            onPressed: () {
                              if (sigingloblekey.currentState!.validate()) {
                                signinuser();
                              }
                            })
                      ],
                    )),
              ),
          ],
        ),
      )),
    );
  }
}
