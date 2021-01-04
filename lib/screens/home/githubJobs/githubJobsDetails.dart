import 'package:flutter/material.dart';

class GithubJobsDetails extends StatefulWidget {
  final String imgUrl,
      title,
      desc,
      // content,
      posturl,
      companyName,
      companyUrl,
      location,
      howToApply,
      companyLogo,
      type;

  GithubJobsDetails(
      {this.imgUrl,
      this.title,
      this.desc,
      // this.content,
      this.posturl,
      this.companyLogo,
      this.companyName,
      this.companyUrl,
      this.howToApply,
      this.location,
      this.type});
  @override
  _GithubJobsDetailsState createState() => _GithubJobsDetailsState();
}

class _GithubJobsDetailsState extends State<GithubJobsDetails> {
  Color mainColor = Color(0xff2FD159);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          widget.companyName,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.network(
              widget.companyLogo,
              height: 150,
            ),

            Text(
              "Join as " + widget.title,
              style: new TextStyle(
                fontSize: 25.0,
                fontStyle: FontStyle.normal,
                height: 2.5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.type,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                height: 2.5,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            // Text(
            //   widget.companyName,
            //   style: new TextStyle(
            //       fontSize: 25.0,
            //       fontStyle: FontStyle.normal,
            //       height: 2.5,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black),
            //   textAlign: TextAlign.center,
            // ),
            Text(
              "Location:- " + widget.location,
              style: new TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  height: 2.5,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.desc,
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
