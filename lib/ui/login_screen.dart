import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username;
  String? password;

  @override
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isSignedIn = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/covid.png',
              fit: BoxFit.cover,
              width: 200,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'PirataOne',
                fontSize: 30.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(fontFamily: 'Oswald'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontFamily: 'Oswald'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        if (usernameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Fill The Username'),
                            ),
                          );
                        } else {
                          isSignedIn = true;
                        }

                        if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Fill The Password'),
                            ),
                          );
                        } else {
                          isSignedIn = true;
                        }

                        if (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(
                                username: usernameController.text,
                                password: passwordController.text,
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      },
                    );
                  },
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(5.0),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.blue,
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(5.0),
                  backgroundColor: WidgetStatePropertyAll(Colors.red)),
              child: Text(
                'Register',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
