import 'package:flutter/material.dart';
import 'package:my_db_103/my_db_helper.dart';
import 'package:my_db_103/note_model.dart';
import 'package:my_db_103/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> arrNotes = [];

  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    updateUIonStart();
  }

  void updateUIonStart() async{
    arrNotes = await getNotes();
    setState(() {

    });
  }

  void addNote(NoteModel note) async {
    bool check = await MyDbHelper().addNote(note);

    print(check ? 'Note Added!' : 'Note not Added!');

    if (check) {
      arrNotes = await getNotes();
      setState(() {});
      print(arrNotes);
    }
  }

  Future<List<NoteModel>> getNotes() async {
    return await MyDbHelper().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(
          itemCount: arrNotes.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              leading: Text('${arrNotes[index].id}'),
              title: Text('${arrNotes[index].title}'),
              subtitle: Text('${arrNotes[index].desc}'),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Add Note',
                          style: TextStyle(fontSize: 21),
                        ),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                              hintText: 'Enter title',
                              label: Text('Title'),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2))),
                        ),
                        TextField(
                          controller: descController,
                          decoration: InputDecoration(
                              hintText: 'Enter Desc',
                              label: Text('Desc'),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    addNote(
                                        NoteModel(title: titleController.text.toString(), desc: descController.text.toString()
                                        )
                                    );

                                    titleController.text = "";
                                    descController.text = "";

                                    Navigator.pop(context);
                                  },
                                  child: Text('Save')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text('Cancel')),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
