import 'package:flutter/material.dart';

class MaintenancePage extends StatefulWidget {
  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  String? _selectedService;
  TextEditingController _queryController = TextEditingController();

  List<String> _maintenanceServices = [
    'Plumber',
    'Electrician',
    'Carpenter',
    'Painter',
    'Gardener',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Maintenance Service:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedService,
              items: _maintenanceServices.map((String service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedService = newValue;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Service',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter Your Query:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _queryController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your query...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _submitQuery();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitQuery() {
    // Implement your logic to submit the query
    String? service = _selectedService;
    String query = _queryController.text;
    // Validate that a service is selected
    if (service != null && service.isNotEmpty) {
      // Do something with the service and query data
      print('Selected Service: $service');
      print('Query: $query');
      // Clear the text field after submission
      _queryController.clear();
      // Optionally, you can show a snackbar or toast to indicate successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Query submitted successfully!'),
        ),
      );
    } else {
      // Show an error message if no service is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a service.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }
}
