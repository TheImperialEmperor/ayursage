class FormValidator {
  // Name validation
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    // Regex to allow only alphabets and spaces
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())) {
      return 'Name can only contain alphabets';
    }
    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }
    // Regex for 10-digit phone number
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  // Aadhaar number validation
  static String? validateAadhaarNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Aadhaar number cannot be empty';
    }
    // Regex for 12-digit Aadhaar number
    if (!RegExp(r'^\d{12}$').hasMatch(value.trim())) {
      return 'Aadhaar number must be 12 digits';
    }
    return null;
  }

  // Registration number validation
  static String? validateRegistrationNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Registration number cannot be empty';
    }
    // Add specific validation for registration number format if needed
    if (value.trim().length < 5) {
      return 'Registration number must be at least 5 characters long';
    }
    return null;
  }

  // Dropdown validation
  static String? validateDropdown(String? value) {
    if (value == null || 
        value.isEmpty || 
        value == 'Select Qualification' || 
        value == 'Select Program' || 
        value == 'Select Blood Group' || 
        value == 'Select Gender') {
      return 'Please select an option';
    }
    return null;
  }

  // Date of Birth validation
  static String? validateDateOfBirth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date of Birth cannot be empty';
    }
    
    try {
      // Parse the date
      List<String> dateParts = value.split('-');
      if (dateParts.length != 3) {
        return 'Invalid date format';
      }
      
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      // Create DateTime object
      DateTime dob = DateTime(year, month, day);
      DateTime currentDate = DateTime.now();
      
      // Check if date is in the past
      if (dob.isAfter(currentDate)) {
        return 'Date of Birth cannot be in the future';
      }
      
      // Optional: Add age restrictions if needed
      int age = currentDate.year - dob.year;
      if (currentDate.month < dob.month || 
          (currentDate.month == dob.month && currentDate.day < dob.day)) {
        age--;
      }
      
      if (age < 18) {
        return 'Must be at least 18 years old';
      }
      
      return null;
    } catch (e) {
      return 'Invalid date';
    }
  }
}
