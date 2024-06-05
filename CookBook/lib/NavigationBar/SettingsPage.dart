import 'package:cookbook/NavigationBar/AdminMenuPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<Settings> {

  static Future<User?> loginUsingEmailPassword(
      {required String email,
        required String password,
        required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }

    return user;
  }

  @override
  void initState() {
    // _counter = 0;
    super.initState();
  }

  String currentLanguage = "English";
  List<String> languages = ["English", "Українська", "Polski"];

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin page",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Login to Admin Functions",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: false,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        hintText: "E-mail",
                        prefixIcon: Icon(Icons.mail , color: Colors.black)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock , color: Colors.black)),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      if (email.isNotEmpty && password.isNotEmpty) {
                        User? user = await loginUsingEmailPassword(
                            email: email, password: password, context: context);
                        print(user);
                        if (user != null) {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => AdminMenu(adminEmail: email)));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminMenu()));
                        }
                      } else {
                        print("Please fill in all fields.");
                      }
                    },
                    child: const Text("Sign in"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentLanguage = languages[
                  (languages.indexOf(currentLanguage) + 1) %
                      languages.length];
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Text(
                currentLanguage,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
