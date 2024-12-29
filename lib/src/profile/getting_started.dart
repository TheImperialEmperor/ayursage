import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authentication/controllers/getting_started_controller.dart';
import '../utils/form_validation.dart';

// State management using Riverpod
final selectedGroupProvider = StateProvider<String>((ref) => '');
final showDetailsProvider = StateProvider<bool>((ref) => false);

class GettingStartedScreen extends ConsumerWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Get.put(GettingStartedController());
    final selectedGroup = ref.watch(selectedGroupProvider);
    final showDetails = ref.watch(showDetailsProvider);
    Get.put(GettingStartedController());
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
        return const DoctorDetailsForm();
      case 'Student':
        return const StudentDetailsForm();
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
  final GettingStartedController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  // Qualification options
  final List<String> _qualificationOptions = [
    'Select Qualification',
    'MBBS',
    'MD',
    'DO',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers from the main controller
    _controller.firstNameController.clear();
    _controller.lastNameController.clear();
    _controller.phoneController.clear();
    _controller.registrationNumberController.clear();
    _controller.instituteNameController.clear();
    _controller.qualificationLevelController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // First Name Field
          TextFormField(
            controller: _controller.firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateName,
          ),
          const SizedBox(height: 16),

          // Last Name Field
          TextFormField(
            controller: _controller.lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateName,
          ),
          const SizedBox(height: 16),

          // Phone Number Field
          TextFormField(
            controller: _controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validatePhoneNumber,
          ),
          const SizedBox(height: 16),

          // Registration Number Field
          TextFormField(
            controller: _controller.registrationNumberController,
            decoration: InputDecoration(
              labelText: 'Registration Number',
              prefixIcon: Icon(Icons.medical_services),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateRegistrationNumber,
          ),
          const SizedBox(height: 16),

          // Institute Name Field
          TextFormField(
            controller: _controller.hospitalNameController,
            decoration: InputDecoration(
              labelText: 'Institution Name',
              prefixIcon: Icon(Icons.school),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Institution name cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Qualification Dropdown
          DropdownButtonFormField<String>(
            value: _controller.qualificationLevelController.text.isEmpty
                ? 'Select Qualification'
                : _controller.qualificationLevelController.text,
            decoration: InputDecoration(
              labelText: 'Qualification',
              prefixIcon: Icon(Icons.school_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: _qualificationOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: FormValidator.validateDropdown,
            onChanged: (value) {
              setState(() {
                _controller.qualificationLevelController.text = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          // Optional: Submit Button (if needed separately)
          ElevatedButton(
            onPressed: _validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
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
    );
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      // Perform submission logic
      _controller.uploadDetailsToFirebase(0); // 0 represents Doctor
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


class StudentDetailsForm extends StatefulWidget {
  const StudentDetailsForm({Key? key}) : super(key: key);

  @override
  _StudentDetailsFormState createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends State<StudentDetailsForm> {
  final GettingStartedController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  // Pursuing options
  final List<String> _pursuingOptions = [
    'Select Program',
    'Undergraduate',
    'Postgraduate',
    'Diploma',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers from the main controller
    _controller.firstNameController.clear();
    _controller.lastNameController.clear();
    _controller.phoneController.clear();
    _controller.collegeIdController.clear();
    _controller.instituteNameController.clear();
    _controller.degreeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // First Name Field
          TextFormField(
            controller: _controller.firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateName,
          ),
          const SizedBox(height: 16),

          // Last Name Field
          TextFormField(
            controller: _controller.lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateName,
          ),
          const SizedBox(height: 16),

          // Phone Number Field
          TextFormField(
            controller: _controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validatePhoneNumber,
          ),
          const SizedBox(height: 16),

          // College ID Field
          TextFormField(
            controller: _controller.collegeIdController,
            decoration: InputDecoration(
              labelText: 'College ID',
              prefixIcon: Icon(Icons.badge),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'College ID cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // College Name Field
          TextFormField(
            controller: _controller.instituteNameController,
            decoration: InputDecoration(
              labelText: 'College Name',
              prefixIcon: Icon(Icons.school),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'College Name cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Pursuing Dropdown
          DropdownButtonFormField<String>(
            value: _controller.degreeController.text.isEmpty
                ? 'Select Program'
                : _controller.degreeController.text,
            decoration: InputDecoration(
              labelText: 'Pursuing',
              prefixIcon: Icon(Icons.book),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: _pursuingOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: FormValidator.validateDropdown,
            onChanged: (value) {
              setState(() {
                _controller.degreeController.text = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          // Optional: Submit Button (if needed separately)
          ElevatedButton(
            onPressed: _validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
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
    );
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      // Perform submission logic
      _controller.uploadDetailsToFirebase(1); // 1 represents Student
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please correct the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


class PatientDetailsForm extends StatefulWidget {
  const PatientDetailsForm({Key? key}) : super(key: key);

  @override
  _PatientDetailsFormState createState() => _PatientDetailsFormState();
}

class _PatientDetailsFormState extends State<PatientDetailsForm> {
  final GettingStartedController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  // Blood Group Options
  final List<String> _bloodGroupOptions = [
    'Select Blood Group',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  // Gender Options
  final List<String> _genderOptions = [
    'Select Gender',
    'Male',
    'Female',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers from the main controller
    _controller.firstNameController.clear();
    _controller.lastNameController.clear();
    _controller.phoneController.clear();
    _controller.aadhaarNumberController.clear();
    _controller.dateOfBirthController.clear();
    _controller.bloodGroupController.clear();
    _controller.genderController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // First Name Field
          TextFormField(
            controller: _controller.firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateName,
          ),
          const SizedBox(height: 16),

          // Last Name Field
          TextFormField(
            controller: _controller.lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateName,
          ),
          const SizedBox(height: 16),

          // Phone Number Field
          TextFormField(
            controller: _controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validatePhoneNumber,
          ),
          const SizedBox(height: 16),

          // Aadhaar Number Field
          TextFormField(
            controller: _controller.aadhaarNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Aadhaar Number',
              prefixIcon: Icon(Icons.assignment_ind),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormValidator.validateAadhaarNumber,
          ),
          const SizedBox(height: 16),

          // Date of Birth Field
          TextFormField(
            controller: _controller.dateOfBirthController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                  _controller.dateOfBirthController.text =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                });
              }
            },
          ),
          const SizedBox(height: 16),

          // Blood Group Dropdown
          DropdownButtonFormField<String>(
            value: _controller.bloodGroupController.text.isEmpty
                ? 'Select Blood Group'
                : _controller.bloodGroupController.text,
            decoration: InputDecoration(
              labelText: 'Blood Group',
              prefixIcon: Icon(Icons.bloodtype),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: _bloodGroupOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: FormValidator.validateDropdown,
            onChanged: (value) {
              setState(() {
                _controller.bloodGroupController.text = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          // Gender Dropdown
          DropdownButtonFormField<String>(
            value: _controller.genderController.text.isEmpty
                ? 'Select Gender'
                : _controller.genderController.text,
            decoration: InputDecoration(
              labelText: 'Gender',
              prefixIcon: Icon(Icons.wc),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: _genderOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: FormValidator.validateDropdown,
            onChanged: (value) {
              setState(() {
                _controller.genderController.text = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          // Optional: Submit Button (if needed separately)
          ElevatedButton(
            onPressed: _validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
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
    );
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      // Perform submission logic
      _controller.uploadDetailsToFirebase(2); // 2 represents Patient
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please correct the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

