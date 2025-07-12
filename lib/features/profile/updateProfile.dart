import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/widgets/custom_button.dart';
import '../services/api_service.dart';
import '../auth/models/user_model.dart';
import 'CustomProfileInput.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  late TextEditingController _fullNameC;
  late TextEditingController _phoneC;
  late TextEditingController _jobC;
  late TextEditingController _addressC;
  late TextEditingController _nationalIdC;
  late TextEditingController _vehicleC;

  File? _licenseFile;
  String? _licenseFileName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullNameC = TextEditingController(text: widget.user.fullName);
    _phoneC = TextEditingController(text: widget.user.phoneNumber);
    _jobC = TextEditingController(text: ''); // Job title should be separate
    _addressC = TextEditingController(text: widget.user.address);
    _nationalIdC = TextEditingController(text: widget.user.nationalId);
    _vehicleC = TextEditingController(text: widget.user.carDashboard);
  }

  @override
  void dispose() {
    _fullNameC.dispose();
    _phoneC.dispose();
    _jobC.dispose();
    _addressC.dispose();
    _nationalIdC.dispose();
    _vehicleC.dispose();
    super.dispose();
  }

  Future<void> _pickLicenseFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        setState(() {
          _licenseFile = File(result.files.single.path!);
          _licenseFileName = result.files.single.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedUser = UserModel(
        fullName: _fullNameC.text,
        email: widget.user.email,
        phoneNumber: _phoneC.text,
        nationalId: _nationalIdC.text,
        address: _addressC.text,
        licenseNumber: widget.user.licenseNumber, // Keep original license number
        numberOfCars: widget.user.numberOfCars,
        carDashboard: _vehicleC.text,
      );

      // Call update with optional file
      await _apiService.updateUserProfile(
        user: updatedUser,
        jobTitle: _jobC.text,
        licenseFile: _licenseFile, // This can be null
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, updatedUser);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Edit Profile'),
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/notification.png', width: 30),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.asset('assets/images/avatar.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomProfileInput(
                    label: 'Full Name',
                    controller: _fullNameC,
                    hintText: "Ali Alaa",
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  CustomProfileInput(
                    label: 'Phone Number',
                    controller: _phoneC,
                    hintText: "0123456789",
                    keyboardType: TextInputType.phone,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  CustomProfileInput(
                    label: 'Job Title',
                    controller: _jobC,
                    hintText: "UI/UX Designer",
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  CustomProfileInput(
                    label: 'Address',
                    controller: _addressC,
                    hintText: "Egypt",
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  CustomProfileInput(
                    label: 'National ID',
                    controller: _nationalIdC,
                    hintText: "30105011202020",
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  CustomProfileInput(
                    label: 'Vehicle Type',
                    controller: _vehicleC,
                    hintText: "Toyota",
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  // Optional file upload section
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Driving License',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.upload_file, color: Colors.blue),
                              onPressed: _pickLicenseFile,
                            ),
                            Expanded(
                              child: Text(
                                _licenseFileName ?? "No file selected",
                                style: TextStyle(
                                  color: _licenseFileName != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (_licenseFile != null)
                              IconButton(
                                icon: const Icon(Icons.clear, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _licenseFile = null;
                                    _licenseFileName = null;
                                  });
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Save",
                    onPressed: _isLoading ? null : _saveProfile,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}