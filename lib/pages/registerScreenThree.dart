import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'dart:convert';

class RegisterScreenThree extends StatefulWidget {
  final String name;
  final String username;
  final String email;
  final String password;
  final String gender;
  final int day;
  final String month;
  final int year;
  final String? phone;

  const RegisterScreenThree({
    super.key,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.gender,
    required this.day,
    required this.month,
    required this.year,
    this.phone,
  });

  @override
  _RegisterScreenThreeState createState() => _RegisterScreenThreeState();
}

class _RegisterScreenThreeState extends State<RegisterScreenThree> {
  List<dynamic> countries = [];
  String selectedCountry = '';
  String selectedFlag = '';
  late TextEditingController phoneControl;

  @override
  void initState() {
    super.initState();
    fetchCountries();
    phoneControl = TextEditingController(text: widget.phone ?? '');
  }

  Future<void> fetchCountries() async {
    const url = 'https://restcountries.com/v3.1/all';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          countries = data
              .where((country) =>
                  country['name'] != null &&
                  country['idd'] != null &&
                  country['flags'] != null &&
                  country['idd']['root'] != null)
              .toList();

          countries.sort((a, b) {
            return a['name']['common']
                .toString()
                .toLowerCase()
                .compareTo(b['name']['common'].toString().toLowerCase());
          });

          String defaultCountryName = 'India';
          var defaultCountry = countries.firstWhere(
              (country) =>
                  country['name']['common'].toString() == defaultCountryName,
              orElse: () => countries[0]);

          selectedCountry = defaultCountry['name']['common'] +
              ' +' +
              (defaultCountry['idd']['root'] ?? '') +
              (defaultCountry['idd']['suffixes']?.first ?? '');
          selectedFlag = defaultCountry['flags']['png'] ?? '';
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveUserData() async {
    try {
      String cleanedCountry =
          selectedCountry.trim().replaceAll(RegExp(r'\+\+'), '+');

      final userData = {
        'name': widget.name,
        'username': widget.username,
        'email': widget.email,
        'password': widget.password,
        'gender': widget.gender,
        'birthdate': {
          'day': widget.day,
          'month': widget.month,
          'year': widget.year
        },
        'phone': phoneControl.text,
        'country': cleanedCountry,
      };

      print('User data to be saved: $userData');

      await FirebaseFirestore.instance.collection('users').add(userData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data saved successfully!')),
      );
    } catch (e) {
      print('Error saving user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving user data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amber,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      '3/3',
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
            const Text(
              "Select Your Country:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton(
                value: selectedCountry.isNotEmpty ? selectedCountry : null,
                isExpanded: true,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                items: countries.map((country) {
                  String countryName = country['name']['common'];
                  String countryCode = country['idd']['root'] +
                      (country['idd']['suffixes']?.first ?? '');
                  String flagUrl = country['flags']['png'];
                  return DropdownMenuItem(
                    value: '$countryName +$countryCode',
                    child: Row(
                      children: [
                        Image.network(
                          flagUrl,
                          width: 25,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '$countryName $countryCode',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountry = newValue!;
                    selectedFlag = countries.firstWhere(
                      (country) =>
                          country['name']['common'] +
                              ' +' +
                              country['idd']['root'] +
                              (country['idd']['suffixes']?.first ?? '') ==
                          newValue,
                    )['flags']['png'];
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneControl,
              decoration: InputDecoration(
                labelText: "Enter Phone Number",
                prefixIcon: const Icon(Icons.phone),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      phoneControl.clear();
                    });
                  },
                  child: const Icon(Icons.cancel),
                ),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                // Check if value is not empty
                if (value == null || value.isEmpty) {
                  return 'Phone Number is required';
                }

                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  return 'Phone Number must be 10 digits long and contain only numbers';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            RawMaterialButton(
              onPressed: saveUserData,
              fillColor: Colors.black,
              constraints: const BoxConstraints(minWidth: 2000, minHeight: 45),
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
