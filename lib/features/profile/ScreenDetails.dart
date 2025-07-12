import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class SessionDetailScreen extends StatefulWidget {
  const SessionDetailScreen({Key? key}) : super(key: key);

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchSession() async {
    final response = await _dio.get(
      'https://5a048d43246f.ngrok-free.app/api/v1/sessions/1/latest',
      options: Options(
        headers: {'accept': 'application/json'},
      ),
    );
    if (response.statusCode == 200) {
      var data = response.data;
      if (data is String) {
        data = json.decode(data);
      }

      // Debug line to see what data we're getting
      print('API Response: ${json.encode(data)}');

      return data as Map<String, dynamic>;
    } else {
      throw Exception("Failed to fetch session: ${response.statusCode}");
    }
  }

  List<Widget> _buildSessionFields(Map<String, dynamic> data) {
    List<Widget> widgets = [];

    // Process regular fields first, but store total_fine_amount position
    bool totalFineAdded = false;
    List<Widget> fineDetailsWidgets = [];

    // Prepare fine details widgets if they exist
    if (data.containsKey('fines_details') && data['fines_details'] != null) {
      List fines = data['fines_details'];
      if (fines.isNotEmpty) {
        fineDetailsWidgets.add(Container(
          margin: const EdgeInsets.only(top: 10, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: const Text(
            'Fine Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ));
        for (var fine in fines) {
          fineDetailsWidgets.add(_buildFineWidget(fine));
        }
      }
    }

    // Add regular fields
    data.entries.forEach((entry) {
      // Skip complex types and fines_details as we'll handle them separately
      if (entry.key == 'violations' || entry.key == 'fines_details') return;

      String key = entry.key.toString().replaceAll('_', ' ').replaceFirstMapped(
          RegExp(r'^\w'), (m) => m.group(0)!.toUpperCase());
      String value = entry.value == null
          ? '-'
          : entry.value is Map || entry.value is List
          ? ''
          : entry.value.toString();

      if (value.isNotEmpty) {
        widgets.add(Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x155A6CEA),
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ],
            border: Border.all(color: const Color(0xFFE0E6ED)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  key,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.indigo,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ));

        // Add fine details right after total fine amount
        if ((entry.key == 'total_fine_amount' || entry.key == 'total_fines_amount' ||
            entry.key == 'fines_amount' || entry.key == 'total_fines') &&
            !totalFineAdded && fineDetailsWidgets.isNotEmpty) {
          widgets.addAll(fineDetailsWidgets);
          totalFineAdded = true;
        }
      }
    });

    // If total fine amount wasn't found but we have fine details, add them at the end of regular fields
    if (!totalFineAdded && fineDetailsWidgets.isNotEmpty) {
      widgets.addAll(fineDetailsWidgets);
    }

    // Add violations section at the end
    if (data.containsKey('violations') && data['violations'] != null) {
      List violations = data['violations'];
      if (violations.isNotEmpty) {
        widgets.add(const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'Violations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ));
        for (var violation in violations) {
          widgets.add(_buildViolationWidget(violation));
        }
      }
    }

    return widgets;
  }

  Widget _buildViolationWidget(Map<String, dynamic> violation) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x155A6CEA),
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
        border: Border.all(color: const Color(0xFFE0E6ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Violation Type: ${violation['violation_type']}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text('Timestamp: ${violation['timestamp']}'),
          Text('Duration: ${violation['duration_seconds']} seconds'),
          Text('Speed: ${violation['speed_kmh']} km/h'),
          if (violation['location'] != null)
            Text(
                'Location: ${violation['location']['latitude']}, ${violation['location']['longitude']}'),
          const SizedBox(height: 8),
          if (violation['snapshot_url'] != null)
            Image.network(
              violation['snapshot_url'],
              height: 100,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.error_outline, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFineWidget(Map<String, dynamic> fine) {
    // Format timestamp to user-friendly format
    String formattedDate = '-';
    try {
      DateTime dateTime = DateTime.parse(fine['timestamp']);
      formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(dateTime);
    } catch (e) {
      formattedDate = fine['timestamp'] ?? '-';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.shade50,
            Colors.orange.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30FFA726),
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
        border: Border.all(color: Colors.orange.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  fine['fine_type'] ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${fine['amount'] ?? '0'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  fine['reason'] ?? 'No reason provided',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.orange.shade700, size: 18),
              const SizedBox(width: 8),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Latest trip details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildSessionFields(snapshot.data!),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "No data available",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}