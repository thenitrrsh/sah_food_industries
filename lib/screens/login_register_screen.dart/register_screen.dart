import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stack(
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //           color: Colors.black54,
            //           width: 1.0,
            //         ),
            //       ),
            //       child: CircleAvatar(
            //         radius: 58,
            //         backgroundColor: Colors.white,
            //         //backgroundImage: ,
            //         // child: Image.asset(
            //         //   'assets/user.png',
            //         //   color: Colors.blue,
            //         //   height: 50,
            //         //   width: 50,
            //         // )
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(
            //           top: MediaQuery.of(context).size.width / 5,
            //           left: MediaQuery.of(context).size.width / 4.2),
            //       child: const CircleAvatar(
            //           backgroundColor: Colors.blue,
            //           radius: 15,
            //           child: Icon(Icons.arrow_upward_outlined)),
            //     ),
            //   ],
            // ),
            CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/logo_sfi.png',
                  // color: Colors.blue,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Card(
                color: Color(0xffDEDCFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  // style: TextStyle(backgroundColor: Color(0xFF848DFF)),
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),

                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    hintText: "Name",
                    hintStyle: TextStyle(color: Constants.bgBlueColor),
                    // fillColor: Color(0xFF848DFF),
                    // contentPadding: EdgeInsets.only(left: 10, right: 5)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Card(
                color: const Color(0xffDEDCFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  // style: TextStyle(backgroundColor: Color(0xFF848DFF)),
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),

                    prefixIcon: Icon(
                      Icons.phone_android,
                      color: Colors.black,
                    ),
                    hintText: "Phone Number",
                    hintStyle: TextStyle(color: Constants.bgBlueColor),
                    // fillColor: Color(0xFF848DFF),
                    // contentPadding: EdgeInsets.only(left: 10, right: 5)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Card(
                color: const Color(0xffDEDCFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  // style: TextStyle(backgroundColor: Color(0xFF848DFF)),
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),

                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Constants.bgBlueColor),
                    // fillColor: Color(0xFF848DFF),
                    // contentPadding: EdgeInsets.only(left: 10, right: 5)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Card(
                color: Color(0xffDEDCFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  obscureText: true,
                  // style: TextStyle(backgroundColor: Color(0xFF848DFF)),
                  decoration: InputDecoration(
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
              child: Card(
                color: const Color(0xffDEDCFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  obscureText: true,
                  // style: TextStyle(backgroundColor: Color(0xFF848DFF)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),

                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Constants.bgBlueColor),
                    // fillColor: Color(0xFF848DFF),
                    // contentPadding: EdgeInsets.only(left: 10, right: 5)
                  ),
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
                      borderRadius: BorderRadius.all(
                          Radius.circular(25))), //Defines Elevation
                  // shadowColor: MaterialStateProperty.all(color), //Defines shadowColor
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => GpsPage()));
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 85.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text("Already have an account? "),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Constants.bgBlueColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
