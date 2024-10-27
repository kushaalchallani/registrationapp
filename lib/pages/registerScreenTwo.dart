import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simpleregistrationapp/pages/registerScreenThree.dart';

class RegisterScreenTwo extends StatefulWidget {
  final String name;
  final String username;
  final String email;
  final String password;

  const RegisterScreenTwo({
    super.key,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterScreenTwo> createState() => _RegisterScreenTwoState();
}

class _RegisterScreenTwoState extends State<RegisterScreenTwo> {
  String? selectedGender = 'Male';
  int selectedDay = 6;
  String selectedMonth = 'Oct';
  int selectedYear = 1993;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final List<int> years = List<int>.generate(100, (index) => 1925 + index);

  int _daysInMonth(String month, int year) {
    switch (month) {
      case 'Jan':
      case 'Mar':
      case 'May':
      case 'Jul':
      case 'Aug':
      case 'Oct':
      case 'Dec':
        return 31;
      case 'Apr':
      case 'Jun':
      case 'Sep':
      case 'Nov':
        return 30;
      case 'Feb':
        return (isLeapYear(year)) ? 29 : 28;
      default:
        return 0;
    }
  }

  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  List<int> get days {
    int daysInCurrentMonth = _daysInMonth(selectedMonth, selectedYear);
    return List<int>.generate(daysInCurrentMonth, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amber,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
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
                        '2/3',
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

              // Gender Selection
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Gender',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const Text('Female'),
                  Radio(
                    value: 'Other',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const Text('Other'),
                ],
              ),
              const Divider(color: Colors.black, thickness: 2),

              const SizedBox(height: 20),

              // Date Picker
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Birthdate',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Day Picker
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: selectedDay - 1),
                        itemExtent: 40.0,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedDay = days[index];
                          });
                        },
                        children: days.map((day) {
                          return Center(
                            child: Text(
                              day.toString(),
                              style: const TextStyle(fontSize: 22),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // Month Picker
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: months.indexOf(selectedMonth)),
                        itemExtent: 40.0,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedMonth = months[index];

                            if (selectedDay >
                                _daysInMonth(selectedMonth, selectedYear)) {
                              selectedDay =
                                  _daysInMonth(selectedMonth, selectedYear);
                            }
                          });
                        },
                        children: months.map((month) {
                          return Center(
                            child: Text(
                              month,
                              style: const TextStyle(fontSize: 22),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // Year Picker
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: years.indexOf(selectedYear)),
                        itemExtent: 40.0,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedYear = years[index];
                            if (selectedDay >
                                _daysInMonth(selectedMonth, selectedYear)) {
                              selectedDay =
                                  _daysInMonth(selectedMonth, selectedYear);
                            }
                          });
                        },
                        children: years.map((year) {
                          return Center(
                            child: Text(
                              year.toString(),
                              style: const TextStyle(fontSize: 22),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreenThree(
                        name: widget.name,
                        username: widget.username,
                        email: widget.email,
                        password: widget.password,
                        gender: selectedGender!,
                        day: selectedDay,
                        month: selectedMonth,
                        year: selectedYear,
                      ),
                    ),
                  );
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
