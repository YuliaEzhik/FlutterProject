import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookbook/NavigatorBar/AdminMenuPage.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  // static Future<User?> loginUsingEmailPassword(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;

  //   print(email);
  //   print(password);

  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     user = userCredential.user;
  //     print("Вхід успішний для користувача: ${user?.email}");
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       print("Користувача з таким електронною адресою не знайдено.");
  //     } else if (e.code == "wrong-password") {
  //       print("Неправильний пароль.");
  //     } else {
  //       print("Помилка аутентифікації: ${e.message}");
  //     }
  //   } catch (e) {
  //     print("Сталася невідома помилка: $e");
  //   }

  //   return user;
  // }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    print(email);
    print(password);
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
                  const Text(
                    "Admin page",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "E-mail"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AdminMenu(adminEmail: email)));
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
