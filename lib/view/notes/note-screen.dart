import 'package:flutter/material.dart';
import 'package:notes/utils/app-theme.dart';
import 'package:notes/view/create-note-screen.dart';
import 'package:notes/view/note-detail-screen.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with your actual note count
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Note Title'),
              subtitle: Text('Note Preview'),
              trailing: Text('Date/Time'),
              // Replace with note date/time
              onTap: () {
                // Navigate to the note details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          // Navigate to the note editor screen for creating a new note
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNoteScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
