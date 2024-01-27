import 'package:flutter/material.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({Key? key});

  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  String selectedGroup = '';
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Your logo and app name widgets go here
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                'Tell us about yourself',
                style: TextStyle(
                  fontFamily: 'red_hat',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Who are you?',
                style: TextStyle(
                  fontFamily: 'red_hat',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildGroupCard(
                    'Doctor',
                    'girldoc',
                    Colors.white,
                    'doctorGroup',
                    'doctorCheck',
                  ),
                  buildGroupCard(
                    'Student',
                    'student',
                    Colors.white,
                    'studentGroup',
                    'studentCheck',
                  ),
                  buildGroupCard(
                    'Guest',
                    'person',
                    Colors.white,
                    'patientGroup',
                    'patientCheck',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: showDetails,
                child: buildDetailsForm(selectedGroup),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle proceed button click
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(
                    fontFamily: 'red_hat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGroupCard(
      String title,
      String image,
      Color backgroundColor,
      String groupId,
      String checkId,
      ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGroup = title;
          showDetails = true;
        });
      },
      child: MaterialCard(
        backgroundColor: backgroundColor,
        groupId: groupId,
        checkId: checkId,
        title: title,
        image: image,
        isSelected: selectedGroup == title,
      ),
    );
  }

  Widget buildDetailsForm(String selectedGroup) {
    switch (selectedGroup) {
      case 'Doctor':
        return const DoctorDetailsForm();
      case 'Student':
        return const StudentDetailsForm();
      case 'Guest':
        return const GuestDetailsForm();
      default:
        return Container();
    }
  }
}

class MaterialCard extends StatelessWidget {
  final String title;
  final String image;
  final Color backgroundColor;
  final String groupId;
  final String checkId;
  final bool isSelected;

  MaterialCard({
    required this.title,
    required this.image,
    required this.backgroundColor,
    required this.groupId,
    required this.checkId,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: isSelected ? Colors.grey : backgroundColor,
      borderRadius: BorderRadius.circular(25),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset(
            'assets/images/gettingStarted/check.png',
            width: 20,
            height: 20,
            color: isSelected ? Colors.blue : Colors.transparent,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'red_hat',
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class DoctorDetailsForm extends StatelessWidget {
  const DoctorDetailsForm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your registration no.',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your institution name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Select your qualification',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your phone no.',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}

class StudentDetailsForm extends StatelessWidget {
  const StudentDetailsForm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your college ID',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your college name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'What are you pursuing?',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your phone no.',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}

class GuestDetailsForm extends StatelessWidget {
  const GuestDetailsForm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your Aadhaar number',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Select your blood group',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Select your birth date',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your phone no.',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
