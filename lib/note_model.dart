import 'package:my_db_103/my_db_helper.dart';

class NoteModel {
  int? id;
  String? title;
  String? desc;


  NoteModel({this.id, this.title, this.desc});

  factory NoteModel.mapIt(Map<String, dynamic> map) {
    return NoteModel(
      id: map[MyDbHelper.COLUMN_NOTE_ID],
      title: map[MyDbHelper.COLUMN_NOTE_TITLE],
      desc: map[MyDbHelper.COLUMN_NOTE_DESC],
    );
  }

  NoteModel fromMap(Map<String, dynamic> map){
    return NoteModel(
      id: map[MyDbHelper.COLUMN_NOTE_ID],
      title: map[MyDbHelper.COLUMN_NOTE_TITLE],
      desc: map[MyDbHelper.COLUMN_NOTE_DESC],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      MyDbHelper.COLUMN_NOTE_ID : id,
      MyDbHelper.COLUMN_NOTE_TITLE : title,
      MyDbHelper.COLUMN_NOTE_DESC : desc
    };
  }
}
