import 'package:ProfessionConnect/models/user.dart';
import 'package:ProfessionConnect/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ApproveJobsDetails extends StatefulWidget {
  final String position,
      description,
      companyName,
      location,
      salary,
      requirement,
      jobId,
      userUid;

  ApproveJobsDetails({
    this.jobId,
    this.companyName,
    this.description,
    this.location,
    this.position,
    this.requirement,
    this.salary,
    this.userUid,
  });

  @override
  _ApproveJobsDetailsState createState() => _ApproveJobsDetailsState();
}

class _ApproveJobsDetailsState extends State<ApproveJobsDetails> {
  Color mainColor = Color(0xff2FD159);

  @override
  Widget build(BuildContext context) {
    // final currentUserId = Provider.of<User>(context).uid;
    User userdata = Provider.of<User>(context);
    DatabaseService db = DatabaseService(user: userdata);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          widget.companyName ?? 'default value',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.done,
            ),
            onPressed: () {
              db.deleteApproveJobData(jobId: widget.jobId);
              db.updateJobData(
                  widget.companyName,
                  widget.location,
                  widget.position,
                  widget.salary,
                  widget.description,
                  widget.requirement);

              Navigator.pop(context);
              Toast.show("Job Approved", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {
              db.deleteApproveJobData(jobId: widget.jobId);
              Navigator.pop(context);
              Toast.show("Job Deleted/Disapproved", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            // Image.network(
            //   widget.companyLogo,
            //   height: 150,
            // ),

            Text(
              "Join as " + widget.position ?? 'default value',
              style: new TextStyle(
                fontSize: 25.0,
                fontStyle: FontStyle.normal,
                height: 2.5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            // Text(
            //   widget.type,
            //   style: TextStyle(
            //     fontSize: 18.0,
            //     fontWeight: FontWeight.bold,
            //     fontStyle: FontStyle.normal,
            //     height: 2.5,
            //     color: Colors.black,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            Text(
              widget.companyName ?? 'default value',
              style: new TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.normal,
                  height: 2.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              "Location:- " + widget.location ?? 'default value',
              style: new TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  height: 2.5,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.description ?? 'default value',
              style: new TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  // fontWeight: FontWeight.bold,
                  height: 2.5,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),

            // below options will be onlt for app created in Profession Connect
            // Row(
            //   children: <Widget>[
            //     SizedBox(
            //       width: 20.0,
            //     ),
            //     Expanded(
            //       child: RaisedButton(
            //         child: Text("Edit"),
            //         textColor: Colors.white,
            //         color: Colors.blue,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(40)),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //     SizedBox(
            //       width: 20.0,
            //     ),
            //     Expanded(
            //       child: RaisedButton(
            //         child: Text("Delete"),
            //         textColor: Colors.white,
            //         color: Colors.blue,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(40)),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
