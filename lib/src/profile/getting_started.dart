import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State management using Riverpod
final selectedGroupProvider = StateProvider<String>((ref) => '');
final showDetailsProvider = StateProvider<bool>((ref) => false);

class GettingStartedScreen extends ConsumerWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGroup = ref.watch(selectedGroupProvider);
    final showDetails = ref.watch(showDetailsProvider);

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
                  // Handle proceed button click
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

    return Padding(
      padding: const EdgeInsets.all(8.0), // Add padding here
      child: GestureDetector(
        onTap: () {
          if (selectedGroup == title) {
            // Deselect if the same card is clicked again
            ref.read(selectedGroupProvider.notifier).state = "";
            ref.read(showDetailsProvider.notifier).state = false;
          } else {
            // Select the card and show details
            ref.read(selectedGroupProvider.notifier).state = title;
            ref.read(showDetailsProvider.notifier).state = true;
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

class DoctorDetailsForm extends StatelessWidget {
  const DoctorDetailsForm({Key? key}) : super(key: key);

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
  const StudentDetailsForm({Key? key}) : super(key: key);

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
  DateTime? _selectedDate;

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

        // Date of Birth Date Picker
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              labelStyle: TextStyle(
                fontFamily: 'red_hat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(
              _selectedDate == null
                  ? 'Select Date'
                  : "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}",
              style: const TextStyle(
                fontFamily: 'red_hat',
                fontSize: 20,
              ),
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

