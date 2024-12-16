import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authentication/controllers/getting_started_controller.dart';

// State management using Riverpod
final selectedGroupProvider = StateProvider<String>((ref) => '');
final showDetailsProvider = StateProvider<bool>((ref) => false);

class GettingStartedScreen extends ConsumerWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = Get.put(GettingStartedController());
    final selectedGroup = ref.watch(selectedGroupProvider);
    final showDetails = ref.watch(showDetailsProvider);
    final gettingStartedController = Get.put(GettingStartedController());
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
              // Wrap the first two cards in a Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: buildGroupCard(
                      context,
                      ref,
                      'Doctor',
                      'doctor',
                      Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10), // Space between cards
                  Expanded(
                    child: buildGroupCard(
                      context,
                      ref,
                      'Student',
                      'student',
                      Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Add the Guest card below the Row
              buildGroupCard(
                context,
                ref,
                'Guest',
                'user',
                Colors.white,
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: showDetails,
                child: buildDetailsForm(selectedGroup),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedGroup.isNotEmpty ? () {
                  if (selectedGroup == 'Doctor') {
                    gettingStartedController.uploadDetailsToFirebase(0);
                  } else if (selectedGroup == 'Student') {
                    gettingStartedController.uploadDetailsToFirebase(1);
                  } else if (selectedGroup == 'Guest') {
                    gettingStartedController.uploadDetailsToFirebase(2);
                  }
                } : null, // Disable button if no card is selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedGroup.isNotEmpty ? Colors.lightGreen : Colors.grey, // Change color based on selection
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
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
      BuildContext context,
      WidgetRef ref,
      String title,
      String image,
      Color backgroundColor,
      ) {
    final selectedGroup = ref.watch(selectedGroupProvider);
    final gettingStartedController = Get.find<GettingStartedController>();

    return Padding(
      padding: const EdgeInsets.all(8.0), // Add padding here
      child: GestureDetector(
        onTap: () {
          if (selectedGroup == title) {
            // Deselect if the same card is clicked again
            ref.read(selectedGroupProvider.notifier).state = "";
            ref.read(showDetailsProvider.notifier).state = false;
            gettingStartedController.updateSelectedGroup(""); // Notify controller
          } else {
            // Select the card and show details
            ref.read(selectedGroupProvider.notifier).state = title;
            ref.read(showDetailsProvider.notifier).state = true;
            gettingStartedController.updateSelectedGroup(title); // Notify controller
          }
        },
        child: MaterialCard(
          backgroundColor: backgroundColor,
          title: title,
          image: image,
          isSelected: selectedGroup == title,
        ),
      ),
    );
  }


  Widget buildDetailsForm(String selectedGroup) {
    switch (selectedGroup) {
      case 'Doctor':
        return DoctorDetailsForm();
      case 'Student':
        return StudentDetailsForm();
      case 'Guest':
        return const PatientDetailsForm();
      default:
        return Container();
    }
  }
}

class MaterialCard extends StatelessWidget {
  final String title;
  final String image;
  final Color backgroundColor;
  final bool isSelected;

  const MaterialCard({
    required this.title,
    required this.image,
    required this.backgroundColor,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: isSelected ? Colors.grey : backgroundColor,
      borderRadius: BorderRadius.circular(25),
      child: Padding( // Added Padding widget here
        padding: const EdgeInsets.all(16.0), // Adjust padding as needed
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
            Image.asset(
              'assets/images/gettingStarted/$image.png',
              width: 100,
              height: 100,
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
      ),
    );
  }
}

class DoctorDetailsForm extends StatefulWidget {
  const DoctorDetailsForm({Key? key}) : super(key: key);

  @override
  _DoctorDetailsFormState createState() => _DoctorDetailsFormState();
}

class _DoctorDetailsFormState extends State<DoctorDetailsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _instituteNameController = TextEditingController();

  String _selectedQualification = 'Select Qualification';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Name
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Last Name
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Phone Number
        TextFormField(
          controller: _phoneNumberController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),

        // Registration Number
        TextFormField(
          controller: _registrationNumberController,
          decoration: const InputDecoration(
            labelText: 'Registration Number',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Institute Name
        TextFormField(
          controller: _instituteNameController,
          decoration: const InputDecoration(
            labelText: 'Institution Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Qualification Dropdown
        DropdownButtonFormField<String>(
          value: _selectedQualification,
          items: const [
            DropdownMenuItem(value: 'Select Qualification', child: Text('Select Qualification')),
            DropdownMenuItem(value: 'MBBS', child: Text('MBBS')),
            DropdownMenuItem(value: 'MD', child: Text('MD')),
            DropdownMenuItem(value: 'DO', child: Text('DO')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedQualification = value!;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Qualification',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}


class StudentDetailsForm extends StatefulWidget {
  const StudentDetailsForm({Key? key}) : super(key: key);

  @override
  _StudentDetailsFormState createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends State<StudentDetailsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _collegeIdController = TextEditingController();
  final TextEditingController _collegeNameController = TextEditingController();

  String _selectedPursuing = 'Select Program';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Name
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Last Name
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Phone Number
        TextFormField(
          controller: _phoneNumberController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),

        // College ID
        TextFormField(
          controller: _collegeIdController,
          decoration: const InputDecoration(
            labelText: 'College ID',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // College Name
        TextFormField(
          controller: _collegeNameController,
          decoration: const InputDecoration(
            labelText: 'College Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Pursuing Dropdown
        DropdownButtonFormField<String>(
          value: _selectedPursuing,
          items: const [
            DropdownMenuItem(value: 'Select Program', child: Text('Select Program')),
            DropdownMenuItem(value: '', child: Text('Undergraduate')),
            DropdownMenuItem(value: 'Postgraduate', child: Text('Postgraduate')),
            DropdownMenuItem(value: 'Diploma', child: Text('Diploma')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedPursuing = value!;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Pursuing',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}


class PatientDetailsForm extends StatefulWidget {
  const PatientDetailsForm({Key? key}) : super(key: key);

  @override
  _PatientDetailsFormState createState() => _PatientDetailsFormState();
}

class _PatientDetailsFormState extends State<PatientDetailsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();

  String _selectedBloodGroup = 'Select Blood Group';
  String _selectedGender = 'Select Gender';
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Name
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Last Name
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Phone Number
        TextFormField(
          controller: _phoneNumberController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),

        // Aadhaar Number
        TextFormField(
          controller: _aadhaarController,
          decoration: const InputDecoration(
            labelText: 'Aadhaar Number',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Date of Birth with DatePicker
        TextFormField(
          controller: _dateOfBirthController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Date of Birth',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                _dateOfBirthController.text =
                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              });
            }
          },
        ),
        const SizedBox(height: 20),

        // Blood Group Dropdown
        DropdownButtonFormField<String>(
          value: _selectedBloodGroup,
          items: const [
            DropdownMenuItem(value: 'Select Blood Group', child: Text('Select Blood Group')),
            DropdownMenuItem(value: 'A+', child: Text('A+')),
            DropdownMenuItem(value: 'A-', child: Text('A-')),
            DropdownMenuItem(value: 'B+', child: Text('B+')),
            DropdownMenuItem(value: 'B-', child: Text('B-')),
            DropdownMenuItem(value: 'O+', child: Text('O+')),
            DropdownMenuItem(value: 'O-', child: Text('O-')),
            DropdownMenuItem(value: 'AB+', child: Text('AB+')),
            DropdownMenuItem(value: 'AB-', child: Text('AB-')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedBloodGroup = value!;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Blood Group',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Gender Dropdown
        DropdownButtonFormField<String>(
          value: _selectedGender,
          items: const [
            DropdownMenuItem(value: 'Select Gender', child: Text('Select Gender')),
            DropdownMenuItem(value: 'Male', child: Text('Male')),
            DropdownMenuItem(value: 'Female', child: Text('Female')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Gender',
            labelStyle: TextStyle(
              fontFamily: 'red_hat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

