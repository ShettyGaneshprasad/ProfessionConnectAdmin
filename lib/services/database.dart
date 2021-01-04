import 'package:ProfessionConnect/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  User user;
  String uid;
  String email;

  Map data;

  DatabaseService({
    this.user,
  });
  //initializing while registeration
  DatabaseService.withuid({this.uid});

  // used while initializing to save data in db
  Future<void> addDataDuringRegistration({email}) {
    CollectionReference collectionReference =
        Firestore.instance.collection('usersData');
    collectionReference.document(uid).setData({
      'email': email,
    });
  }

  // collection reference
  // final CollectionReference userCollection =
  //     Firestore.instance.collection('userdata');

  // Future<void> updateUserData(String sugars, String name, int strength) async {
  //   return await userCollection.document(uid).setData({
  //     'sugars': sugars,
  //     'name': name,
  //     'strength': strength,
  //   });
  // }

// use to update user data

  Future<void> updateUserData({
    String name,
    String age,
    String profession,
    String location,
    String phoneNo,
    String about,
  }) async {
    String newEmail = user.email;
    String newName = name ?? user.name;
    String newProfession = profession ?? user.profession;
    String newLocation = location ?? user.location;
    String newPhoneNo = phoneNo ?? user.phoneNo;
    String newAbout = about ?? user.about;
    String newAge = age ?? user.age;
    CollectionReference collectionReference =
        Firestore.instance.collection('usersData');

    collectionReference.document(user.uid).setData({
      'email': newEmail,
      'name': newName,
      'profession': newProfession,
      'age': newAge,
      'location': newLocation,
      'phoneNo': newPhoneNo,
      'about': newAbout,
    });
  }

  Future<void> fetchUserData({String userID}) async {
    CollectionReference collectionReference =
        Firestore.instance.collection('usersData');

    collectionReference.snapshots().listen((snapshot) {
      List documents;

      documents = snapshot.documents;

      data = snapshot.documents[0].data;
// informtaion will be in Map data which is a variable for this class

//ooeration use as data['name'].toString();
    });
  }

// to add a new job
  Future<void> updateJobData(
    String companyName,
    String location,
    String position,
    String salary,
    String description,
    String requirement,
  ) async {
    String newdescription = description ?? "description";
    String newposition = position ?? "position";
    String newcompanyName = companyName ?? "Companyname";
    String newRequirement = requirement ?? "Requirement";
    String newLocation = location ?? "Location";

    String newSalary = salary ?? 'Salary';
    CollectionReference collectionReference =
        Firestore.instance.collection('jobListing');
    collectionReference.document().setData({
      'companyName': newcompanyName,
      'position': newposition,
      'description': newdescription,
      'location': newLocation,
      'salary': newSalary,
      'requirment': newRequirement,
      'userUid': user.uid
    });
  }

  //delete a job
  void deleteJobData({String jobId}) {
    CollectionReference collectionReference =
        Firestore.instance.collection('jobListing');
    collectionReference.document(jobId).delete();
  }
}
