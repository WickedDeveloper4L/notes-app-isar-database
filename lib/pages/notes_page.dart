import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_isar_database/components/note_settings.dart';
import 'package:notes_app_isar_database/models/note.dart';
import 'package:notes_app_isar_database/models/notes_database.dart';
import 'package:notes_app_isar_database/theme/theme_provider.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fetch all notes
    readNotes();
  }

  //create
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        actions: [
          //create
          MaterialButton(
            onPressed: () {
              //add to db
              context.read<NotesDatabase>().addNote(textController.text);

              //clear text controller
              textController.clear();
              //pop dialogue
              Navigator.pop(context);
            },
            child: const Text("Create"),
          ),
          //cancel
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  //read
  void readNotes() {
    context.read<NotesDatabase>().fetchNotes();
  }

  //update
  void updateNote(Note note) {
    //pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        title: const Text("Update note"),
        actions: [
          //create
          MaterialButton(
            onPressed: () {
              //add to db
              context
                  .read<NotesDatabase>()
                  .updateNote(note.id, textController.text);

              //clear text controller
              textController.clear();
              //pop dialogue
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
          //cancel
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
  //delete

  void deleteNote(int id) {
    context.read<NotesDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //notes database
    final noteDatabase = context.watch<NotesDatabase>();

    //list of notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.dark_mode),
                  CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      activeColor: Theme.of(context).colorScheme.secondary,
                      onChanged: (value) =>
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme()),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
            onPressed: createNote,
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.inversePrimary,
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Notes",
                style: GoogleFonts.dmSerifText(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  //individul notes
                  final note = currentNotes[index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    child: ListTile(
                        title: Text(
                          note.text,
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                        trailing: Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () => showPopover(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              width: 100,
                              height: 100,
                              context: context,
                              bodyBuilder: (context) => NoteSettings(
                                onDelete: () => deleteNote(note.id),
                                onEdit: () => updateNote(note),
                              ),
                            ),
                          ),
                        )),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
