import 'package:ProfessionConnect/screens/home/ProfessionConnectJobs/professionConnectJobDetails.dart';
import 'package:ProfessionConnect/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'ApproveJobsDetails.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class JobsToBeApproved extends StatefulWidget {
  _JobsToBeApproved createState() => new _JobsToBeApproved();
}

class _JobsToBeApproved extends State<JobsToBeApproved> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> professionConnectJob;

  final CollectionReference collectionReference =
      Firestore.instance.collection("jobsToBeApproved");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        professionConnectJob = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // inside a seperate builder

//  itemCount: professionConnectJob.length,
    return Scaffold(
        backgroundColor: Colors.white,
        body: professionConnectJob != null
            ? ListView.builder(
                itemCount: professionConnectJob.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  String jobId = professionConnectJob[index].documentID;
                  String position =
                      professionConnectJob[index].data['position'];
                  String companyName =
                      professionConnectJob[index].data['companyName'];
                  String description =
                      professionConnectJob[index].data['description'];
                  String requirement =
                      professionConnectJob[index].data['requirement'];
                  String salary = professionConnectJob[index].data['salary'];
                  String userUid = professionConnectJob[index].data['userUid'];
                  String location =
                      professionConnectJob[index].data['location'];

                  return PCTile(
                    jobId: jobId,
                    companyName: companyName,
                    description: description,
                    location: location,
                    position: position,
                    requirement: requirement,
                    salary: salary,
                    userUid: userUid,
                  );
                })
            : new Loading());
  }
}

class PCTile extends StatelessWidget {
  final String position,
      description,
      companyName,
      location,
      salary,
      requirement,
      jobId,
      userUid;
  PCTile({
    this.jobId,
    this.companyName,
    this.description,
    this.location,
    this.position,
    this.requirement,
    this.salary,
    this.userUid,
  });
  final Color mainColor = Color(0xff79fadb);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApproveJobsDetails(
              jobId: jobId,
              description: description,
              position: position,
              requirement: requirement,
              salary: salary,
              companyName: companyName,
              location: location,
              userUid: userUid,
            ),
          ),
        );
      },
      child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 5,
              // color: mainColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    // Image.network(
                    //   imgUrl,
                    //   height: 150,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        position,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Company  :- ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          companyName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Location  :- ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          location,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
