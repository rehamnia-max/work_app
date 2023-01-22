import 'package:dev_mobile_tp/models/auth.dart';
import 'package:dev_mobile_tp/views/main_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmController = TextEditingController();
  AuthModel auth = AuthModel();
  String errorText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: errorText.isNotEmpty,
              child: Text(errorText),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Confirm",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: 140,
              child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                  child: const Text("Signup"),
                  onPressed: () async {
                    if (passwordController!.text == confirmController!.text &&
                        await auth.creatUser(
                            email: emailController!.text,
                            password: passwordController!.text)) {
                      setState(() {
                        errorText = "";
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreen(
                                  title: "title",
                                )),
                      );
                    } else {
                      setState(() {
                        errorText = "There is error";
                      });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
