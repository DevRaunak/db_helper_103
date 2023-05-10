import 'my_db_helper.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? pass;
  String? gender;
  String? mobno;

  UserModel(
      {this.id,
        this.name,
        this.email,
        this.gender,
        this.mobno,
        this.pass});

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      id: map[MyDbHelper.COLUMN_USER_ID],
      name: map[MyDbHelper.COLUMN_USER_NAME],
      email: map[MyDbHelper.COLUMN_USER_EMAIL],
      pass: map[MyDbHelper.COLUMN_USER_PASS],
      gender: map[MyDbHelper.COLUMN_USER_GENDER],
      mobno: map[MyDbHelper.COLUMN_USER_MOB_NO],
    );
  }

    Map<String, dynamic> toMap(){
      return {
        MyDbHelper.COLUMN_USER_ID : id,
        MyDbHelper.COLUMN_USER_NAME : name,
        MyDbHelper.COLUMN_USER_EMAIL : email,
        MyDbHelper.COLUMN_USER_PASS : pass,
        MyDbHelper.COLUMN_USER_GENDER : gender,
        MyDbHelper.COLUMN_USER_MOB_NO: mobno,
      };

  }
}
