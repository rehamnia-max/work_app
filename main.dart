import 'package:dev_mobile_tp/models/auth.dart';
import 'package:dev_mobile_tp/models/settings.dart';
import 'package:dev_mobile_tp/views/main_screen.dart';
import 'package:dev_mobile_tp/views/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Settings().setSettings();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Artisans'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  AuthModel auth = AuthModel();
  String errorText = "";

  @override
  void initState() {
    super.initState();
    //create();
  }

  Future<void> create() async {
    await auth.creatUser(email: "test@test.com", password: "123456");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            SizedBox(
              width: 140,
              child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () async {
                    // if (auth.accessToken!.isNotEmpty ||
                    //     await auth.signIn(
                    //         email: emailController!.text,
                    //         password: passwordController!.text)) {
                    //   setState(() {
                    //     errorText = "";
                    //   });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                                title: "title",
                              )),
                    );
                    //   } else {
                    //     setState(() {
                    //       errorText = "There is error";
                    //     });
                    //   }
                  },
                  child: const Text("Signin")),
            ),
            const Divider(),
            SizedBox(
              width: 140,
              child: TextButton(
                  child: const Text("Signup"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
