import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String infoText = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/create.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  const Color(0xf0000000).withOpacity(0.5),
                  const Color(0xf0000000).withOpacity(0.3),
                ],
                stops: const [
                  0.0,
                  1.0,
                ],
              ),
            ),
          ),
          Container(
            height: 160,
            alignment: Alignment.bottomCenter,
            child: Text(
              'SportsLife',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(
                      'ログイン',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Text(infoText),
                Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'メールアドレス'),
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                    onChanged: (String value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                        } catch (e) {
                          setState(() {
                            infoText = "登録に失敗しました。{$e.toString()}";
                          });
                        }
                      },
                      child: Text(
                        "新規登録",
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginApp()),
                        );
                      },
                      child: Text(
                        "ログイン",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    "<< 戻る",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
