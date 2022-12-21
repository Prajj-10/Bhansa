class UserModel{
  String?uid;
  String?name;
  String?address;
  String?email;
  String?password;

  UserModel({this.uid, this.name, this.address, this.email, this.password});

  // take data from server
  factory UserModel.fromMap(map){
    return UserModel(
        uid:map['uid'],
        name:map['name'],
        address:map['address'],
        email:map['email'],
        password:map['password']
    );
  }

  // sending data to server
  Map<String, dynamic> toMap(){
    return{
      'uid':uid,
      'name':name,
      'address':address,
      'email':email,
      'password':password,
    };
  }



}