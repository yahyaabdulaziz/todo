import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/ui/screens/auth/register/register_screen.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';
import 'package:todo/ui/utilities/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: buildMyBody());
  }

  Widget buildMyBody() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Image(
              image: AssetImage("assets/images/todo_icon.png"),
              height: MediaQuery.of(context).size.height * .25,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'ToDo Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * .08,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.primary),
                  ),
                  child: const Text(
                    'Login',
                    style: AppTheme.appBarTextStyle,
                  ),
                  onPressed: () {
                    login();
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.routeName);
                  },
                )
              ],
            ),
          ],
        ));
  }

  void login() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      /// to storing more data storing it in firestore
      AppUser currentUser =
          await getUserFromFirestore(userCredential.user!.uid);
      AppUser.currentUser = currentUser;
      hideLoading(context);
      showWelcomeLoading(context, AppUser.currentUser!.username);
      Navigator.pushReplacementNamed(context, HomeScreen.roueName);
    } on FirebaseAuthException catch (error) {
      hideLoading(context);
      showErrorMessage(context,
          error.message ?? "SomeThing went wrong, Please Try Again Later...");
    }
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    CollectionReference<AppUser> userCollection = FirebaseFirestore.instance
        .collection(AppUser.collectionName)
        .withConverter<AppUser>(fromFirestore: (snapshot, _) {
      return AppUser.fromJson(snapshot.data()!);
    }, toFirestore: (user, _) {
      return user.toJson();
    });
    DocumentSnapshot<AppUser> documentSnapshot =
        await userCollection.doc(id).get();
    return documentSnapshot.data()!;
  }
}
