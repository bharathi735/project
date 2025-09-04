import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMemberForm extends StatefulWidget {
  const AddMemberForm({super.key});

  @override
  _AddMemberFormState createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<AddMemberForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? _selectedPosition;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  // List of positions for the dropdown
  final List<String> _positions = [
    'President',
    'Vice president',
    'Secretary',
    'Treasurer',
    'Coordinator',
    'Join Secretary',
  ];

  // Firestore method to add member
  Future<void> _addMember() async {
    if (_formKey.currentState!.validate() && _selectedPosition != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Positions')
            .doc(_selectedPosition)
            .collection('Members')
            .doc(_idController.text)
            .set({
          'id': _idController.text,
          'name': _nameController.text,
          'votes': 0,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Member added successfully!')),
        );

        // Clear form fields after submission
        _idController.clear();
        _nameController.clear();
        setState(() {
          _selectedPosition = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Member to Position'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown for position selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Position',
                  border: OutlineInputBorder(),
                ),
                value: _selectedPosition,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPosition = newValue;
                  });
                },
                items: _positions.map((String position) {
                  return DropdownMenuItem<String>(
                    value: position,
                    child: Text(position),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select a position' : null,
              ),
              const SizedBox(height: 16),

              // Member ID Text Field
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'Member ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter member ID' : null,
              ),
              const SizedBox(height: 16),

              // Member Name Text Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Member Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter member name' : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _addMember,
                  child: const Text('Add Member'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
