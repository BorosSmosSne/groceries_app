import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceries_app/models/user.dart';
import 'package:groceries_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<LoginScreen> {
  bool _isCheck = false;
  bool _obsecureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void togglePassword() {
    _obsecureText = !_obsecureText;
    setState(() {});
  }

  Future<void> saveCredentials(User user) async {
    // Save the email and password to local storage or secure storage
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('sv9.pos.token', user.token ?? '');
    // You can use packages like shared_preferences or flutter_secure_storage
  }

  Future<void> login() async {
    final email = 'sv9@gmail.com';
    final password = 'sv9@123';
    if (_emailController.text == email &&
        _passwordController.text == password) {
      final responeToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE4MDAwMDAwMDB9.6n4w6_uCgMbeuY7Vp_tHhUksL8Pq8wW7Fk1Z6_9_5z4';
      await saveCredentials(User(token: responeToken));
      // print('Logged in successfully!');
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login Failed',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text('Invalid email or password'),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/login_app_logo.png",
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 70),
                  Container(
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Add your form fields here
                        Center(
                          child: Text(
                            "Welcome Back!",
                            style: GoogleFonts.workSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Email",
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            // labelText: 'Email',
                            hintText: 'example@gmail.com',
                            labelStyle: GoogleFonts.workSans(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Password",
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obsecureText,
                          decoration: InputDecoration(
                            // labelText: 'Password',
                            hintText: 'Enter your password',
                            labelStyle: GoogleFonts.workSans(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: togglePassword,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheck,
                              onChanged: (value) {
                                // Handle checkbox change
                                _isCheck = value ?? false;
                                setState(() {});
                              },
                            ),
                            Text("Remember Me"),
                            Spacer(),
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          // onPressed: () {
                          //   login();
                          // },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => HomeScreen(),
                            //   ),
                            //   (route) => false,
                            // );
                            login();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60),
                            Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                // Handle sign up action
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/google.png',
                                  height: 35,
                                  width: 35,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/Facebook.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/apples.png',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
