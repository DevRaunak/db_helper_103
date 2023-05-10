import 'package:my_db_103/note_model.dart';
import 'package:my_db_103/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDbHelper {
  //Note
  static const String TABLE_NOTE = "note";
  static const String COLUMN_NOTE_ID = "note_id";
  static const String COLUMN_NOTE_TITLE = "title";
  static const String COLUMN_NOTE_DESC = "desc";

  //user
  static const String TABLE_USER = "user";
  static const String COLUMN_USER_ID = "u_id";
  static const String COLUMN_USER_NAME = "name";
  static const String COLUMN_USER_EMAIL = "email";
  static const String COLUMN_USER_PASS = "pass";
  static const String COLUMN_USER_GENDER = "gender";
  static const String COLUMN_USER_MOB_NO = "mob_no";

  Future<Database> openDB() async {
    var mDirectory = await getApplicationDocumentsDirectory();
    await mDirectory.create(recursive: true);

    var mPath = '${mDirectory.path}/note_db.db';

    return await openDatabase(mPath, version: 1, onCreate: (db, version) {
      db.execute(
          'create table $TABLE_USER ($COLUMN_USER_ID integer primary key autoincrement, '
          '$COLUMN_USER_NAME text, '
          '$COLUMN_USER_EMAIL text, '
          '$COLUMN_USER_PASS text, '
          '$COLUMN_USER_GENDER text, '
          '$COLUMN_USER_MOB_NO text )');

      db.execute(
          'create table $TABLE_NOTE ($COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text)');
    });
  }

  Future<int> SignUp(UserModel user) async {
    var mDb = await openDB();
    int check;
    if (!await checkIfEmailAlreadyExists(user.email!)) {
      check = await mDb.insert(TABLE_USER, user.toMap());
    } else {
      check = -100;
    }
    return check;
  }

  Future<bool> SignIn(String email, String pass) async {
    var mDb = await openDB();

    //mDb.rawQuery('select * from $TABLE_USER where $COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?', [email, pass]);

    List<Map<String, dynamic>> data = await mDb.query(TABLE_USER,
        where: '$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?',
        whereArgs: [email, pass]);


    return data.isNotEmpty;

  }

  Future<bool> checkIfEmailAlreadyExists(String email) async {
    var mDb = await openDB();

    List<Map<String, dynamic>> data = await mDb
        .query(TABLE_USER, where: '$COLUMN_USER_EMAIL = ?', whereArgs: [email]);

    return data.isNotEmpty;
  }

  Future<bool> addNote(NoteModel note) async {
    var mDb = await openDB();

    var check = await mDb.insert(TABLE_NOTE, note.toMap());

    return check > 0;
  }

  Future<List<NoteModel>> getNotes() async {
    var mDb = await openDB();

    List<Map<String, dynamic>> listNotes = await mDb.query(TABLE_NOTE, where: '$COLUMN_USER_ID = ?', whereArgs: [$id]);

    List<NoteModel> listNoteModel = [];

    for (Map<String, dynamic> note in listNotes) {
      listNoteModel.add(NoteModel.mapIt(note));
    }
    return listNoteModel;
  }

  Future<bool> updateNote(int id, String title, String desc) async {
    var mDb = await openDB();

    var check = await mDb.update(
        TABLE_NOTE, {COLUMN_NOTE_TITLE: title, COLUMN_NOTE_DESC: desc},
        where: '$COLUMN_NOTE_ID = ? ', whereArgs: ['$id']);

    return check > 0;
  }

  Future<bool> removeNote(int id) async {
    var mDb = await openDB();

    var check = await mDb
        .delete(TABLE_NOTE, where: '$COLUMN_NOTE_ID = ?', whereArgs: ['$id']);

    return check > 0;
  }
}
