import 'dart:async';
import 'package:autombile/core/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../services/api_service.dart';

class UploadEvidencePage extends StatefulWidget {
  final int emergencyId;
  const UploadEvidencePage({super.key, required this.emergencyId});

  @override
  State<UploadEvidencePage> createState() => _UploadEvidencePageState();
}

class _UploadEvidencePageState extends State<UploadEvidencePage> {
  String? selectedCategory;
  String? fileName;
  String? filePath;
  bool isUploading = false;
  Timer? _timer;
  Duration _duration = const Duration(hours: 24, minutes: 0, seconds: 0);

  final List<String> categories = [
    'medical_request',
    'fire_report',
    'accident_report',

  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime(Timer timer) {
    if (_duration.inSeconds > 0) {
      setState(() {
        _duration -= const Duration(seconds: 1);
      });
    } else {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        fileName = result.files.single.name;
        filePath = result.files.single.path;
      });
    }
  }

  Future<void> _uploadEvidence() async {
    if (selectedCategory == null || filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category & pick a file.')),
      );
      return;
    }
    setState(() { isUploading = true; });

    try {
      final apiService = ApiService();
      await apiService.uploadEvidence(
        emergencyId: widget.emergencyId,
        category: selectedCategory!,
        filePath: filePath!,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evidence uploaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() { isUploading = false; });
    }
  }

  String get timerDisplay {
    final h = _duration.inHours.toString().padLeft(2, '0');
    final m = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    final s = (_duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$h : $m : $s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: AppColor.backGround,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: const Text('Upload Evidence'),
        ),
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer Partial
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.redAccent.shade700,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer, color: Colors.white,),
                  const SizedBox(width: 10),
                  const Text('Timer :', style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(width: 10),
                  Text(timerDisplay, style: const TextStyle(color: Colors.white, fontFamily: 'Digital-7', fontSize: 25, letterSpacing: 2)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Category Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  const Text('Category', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                  const SizedBox(width: 26),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      hint: Text('Select a category',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      items: categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => setState(() { selectedCategory = v; }),
                    ),
                  )
                ],
              ),
            ),

            // Evidence upload
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  const Text('Evidence', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickFile,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue[900],
                        backgroundColor: Colors.grey[100],
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.upload_file),
                      label: Text(fileName == null ? "Add file" : fileName!),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: CustomButton(
                text: "Upload",
                onPressed: _uploadEvidence,
                child: isUploading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
                    :Text('Upload',style: TextStyle(color: Colors.white),)), )
          ],
        ),
      ),
    );
  }
}