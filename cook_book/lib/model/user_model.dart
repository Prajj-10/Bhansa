class UserModel{
  String?uid;
  String?name;
  String?username;
  String?email;
  String?password;
  String?description;

  UserModel({this.uid, this.name, this.username, this.email, this.password, this.description});

  // take data from server
  factory UserModel.fromMap(map){
    return UserModel(
        uid:map['uid'],
        name:map['name'],
        username:map['username'],
        email:map['email'],
        password:map['password'],
        description:map['description']
    );
  }

  // sending data to server
  Map<String, dynamic> toMap(){
    return{
      'uid':uid,
      'name':name,
      'username':username,
      'email':email,
      'password':password,
      'description':description
    };
  }
}