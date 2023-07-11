import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  final noteId;

  const CreateNoteScreen({super.key, this.noteId});
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  String _selectedCollection = '';

  List<String> _collections = [
    'Add Collection',
    'Collection 1',
    'Collection 2',
    'Collection 3',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    // Implement your save logic here
    // You can access the entered title, note, and selected collection using _titleController.text, _noteController.text, and _selectedCollection respectively
  }

  void _showSaveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Changes?'),
          content: Text('Do you want to save the note before leaving?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/notes');
              },
              child: Text('Leave Anyway'),
            ),
            TextButton(
              onPressed: () {
                _saveNote();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/notes');
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _showAddCollectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _newCollectionController =
            TextEditingController();

        return AlertDialog(
          title: Text('Add Collection'),
          content: TextField(
            controller: _newCollectionController,
            decoration: InputDecoration(hintText: 'Enter Collection Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newCollection = _newCollectionController.text.trim();
                if (newCollection.isNotEmpty) {
                  setState(() {
                    _collections.add(newCollection);
                    _selectedCollection = newCollection;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_titleController.text.isNotEmpty ||
            _noteController.text.isNotEmpty) {
          _showSaveConfirmationDialog(context);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Note'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_titleController.text.isNotEmpty ||
                  _noteController.text.isNotEmpty) {
                _showSaveConfirmationDialog(context);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveNote,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value:
                    _selectedCollection.isNotEmpty ? _selectedCollection : null,
                items: _collections.map((String collection) {
                  return DropdownMenuItem<String>(
                    value: collection,
                    child: Text(collection),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value == 'Add Collection') {
                    _showAddCollectionDialog(context);
                  } else {
                    setState(() {
                      _selectedCollection = value!;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Collection',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _noteController,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    labelText: 'Note',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
