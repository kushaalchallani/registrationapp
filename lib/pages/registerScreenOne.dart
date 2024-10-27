import 'package:flutter/material.dart';
import 'package:simpleregistrationapp/pages/registerScreenTwo.dart';

class RegisterScreenOne extends StatefulWidget {
  final String? name;
  final String? username;
  final String? email;
  final String? password;

  const RegisterScreenOne({
    super.key,
    this.name,
    this.username,
    this.email,
    this.password,
  });

  @override
  State<RegisterScreenOne> createState() => _RegisterScreenOneState();
}

class _RegisterScreenOneState extends State<RegisterScreenOne> {
  final checkKey = GlobalKey<FormState>();
  late TextEditingController nameControl;
  late TextEditingController usernameControl;
  late TextEditingController emailControl;
  late TextEditingController passwordControl;
  late bool passwordVisiblity;

  @override
  void initState() {
    super.initState();
    nameControl = TextEditingController(text: widget.name ?? '');
    usernameControl = TextEditingController(text: widget.username ?? '');
    emailControl = TextEditingController(text: widget.email ?? '');
    passwordControl = TextEditingController(text: widget.password ?? '');

    passwordVisiblity = true;
  }

  @override
  void dispose() {
    nameControl.dispose();
    usernameControl.dispose();
    emailControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: checkKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RawMaterialButton(
                    constraints:
                        const BoxConstraints(minHeight: 36, minWidth: 24),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      print('Button pressed!');
                    },
                    child: const Icon(
                      Icons.home,
                      color: Colors.black,
                      weight: 900,
                      size: 24,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "CREATE\nACCOUNT",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        )),
                    child: const Center(
                      child: Text(
                        '1/3',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameControl,
                decoration: InputDecoration(
                  labelText: "Enter Full Name",
                  prefixIcon: const Icon(Icons.edit),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        nameControl.clear();
                      });
                    },
                    child: const Icon(Icons.cancel),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Full Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: usernameControl,
                decoration: InputDecoration(
                  labelText: "Enter Username",
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        usernameControl.clear();
                      });
                    },
                    child: const Icon(Icons.cancel),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailControl,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        emailControl.clear();
                      });
                    },
                    child: const Icon(Icons.cancel),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordControl,
                obscureText: passwordVisiblity,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    child: passwordVisiblity
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onTap: () {
                      setState(() {
                        passwordVisiblity = !passwordVisiblity;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              RawMaterialButton(
                onPressed: () {
                  if (checkKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreenTwo(
                          name: nameControl.text,
                          username: usernameControl.text,
                          email: emailControl.text,
                          password: passwordControl.text,
                        ),
                      ),
                    );
                  }
                },
                fillColor: Colors.black,
                constraints:
                    const BoxConstraints(minWidth: 2000, minHeight: 45),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
