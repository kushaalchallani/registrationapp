import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  late String emailAddress, password;
  late bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      body: Column(
        children: [
          const Text("Please Register Here",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              onChanged: (value) {
                emailAddress = value;
                print(emailAddress);
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Please Enter Your Email",
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              obscureText: showPassword,
              onChanged: (value) {
                password = value;
                print(password);
              },
              decoration: InputDecoration(
                  hintText: "Please Enter Your Password",
                  suffixIcon: GestureDetector(
                    child: showPassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          RawMaterialButton(
            onPressed: () async {
              final authInstance = FirebaseAuth.instance;
              try {
                await authInstance.createUserWithEmailAndPassword(
                    email: emailAddress, password: password);
              } catch (Error) {
                print(Error);
              }
            },
            fillColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Register User"),
            ),
          )
        ],
      ),
    );
  }
}
