class User {
  final String uid;
  final String email;
  String name;
  String profession;
  String age;
  String phoneNo;
  String about;
  String location;

  User(this.uid, this.email,
      [this.about,
      this.name,
      this.phoneNo,
      this.profession,
      this.age,
      this.location]);
}
