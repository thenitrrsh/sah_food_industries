import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sah_food_industries/providers/login_provider.dart';
import 'package:sah_food_industries/screens/login_register_screen.dart/register_screen.dart';
import '../../Constants.dart';
import '../../app/shared_preferences_helper.dart';
import '../dashboard/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                    height: 220,
                    width: 420,
                    child: Image.asset("assets/images/logo_sfi.png")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: Card(
                  color: const Color(0xffDEDCFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    // style: TextStyle(backgroundColor: Color(0xFF848DFF)),
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Constants.bgBlueColor),

                      // fillColor: Color(0xFF848DFF),
                      // contentPadding: EdgeInsets.only(left: 10, right: 5)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                child: Card(
                  color: const Color(0xffDEDCFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    // style: TextStyle(backgroundColor: Color(0xFF848DFF)),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),

                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Constants.bgBlueColor),
                      // fillColor: Color(0xFF848DFF),
                      // contentPadding: EdgeInsets.only(left: 10, right: 5)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0, left: 180),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ForgotPage()));
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xFF5663FF)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 320,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Constants.bgBlueColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    // backgroundColor: MaterialStateProperty.all(
                    //     Color(0xFF5663FF)), //Background Color
                    // elevation: MaterialStateProperty.all(3), //Defines Elevation
                    // shadowColor: MaterialStateProperty.all(color), //Defines shadowColor
                  ),
                  onPressed: () {
                    // _onLogin();
                    _onLogin();


                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont have an account? ",
                        // style: TextStyle(color: Color(0xFF5663FF)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: const Text(
                          "Sign Up ",
                          style: TextStyle(
                              color: Constants.bgBlueColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onLogin() async {
    if (loading.value) {
      return;
    }
    if (formkey.currentState!.validate()) {
      loading.value = true;
      var response = await LoginProvider()
          .login(emailController.text, passwordController.text);
      loading.value = false;
      if (response && mounted) {
        SharedPreferencesHelper.setIsLogin(true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }
    }
  }
}
