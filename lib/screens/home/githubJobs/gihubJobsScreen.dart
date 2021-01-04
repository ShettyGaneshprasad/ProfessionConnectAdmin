import 'package:ProfessionConnect/models/githubJobs.dart';
import 'package:ProfessionConnect/screens/home/githubJobs/githubJobsDetails.dart';
import 'package:ProfessionConnect/services/githubJobs.dart';
import 'package:ProfessionConnect/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class GithubJobScreen extends StatefulWidget {
  @override
  _GithubJobScreenState createState() => _GithubJobScreenState();
  GithubJobScreen({this.githubJobsList});
  final List<GithubJobsModel> githubJobsList;
}

class _GithubJobScreenState extends State<GithubJobScreen> {
  // List<GithubJobsModel> githubJobsList = new List<GithubJobsModel>();

  // bool _loading = true;

  @override
  void initState() {
    // getNews();
    super.initState();
  }

  // getNews() async {
  //   GithubJobs githubJobs = GithubJobs();
  //   print("github jobs object created");
  //   await githubJobs.getNews();
  //   print("exectuted job list and created news");
  //   githubJobsList = githubJobs.githubJobsList;
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          /// Categories

                          /// News Article
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: ListView.builder(
                                itemCount: widget.githubJobsList.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return JobTile(
                                    companyLogo: widget.githubJobsList[index]
                                            .companyLogo ??
                                        "",
                                    companyName: widget.githubJobsList[index]
                                            .companyName ??
                                        "",
                                    companyUrl: widget
                                            .githubJobsList[index].companyUrl ??
                                        "",
                                    howToApply: widget
                                            .githubJobsList[index].howToApply ??
                                        "",
                                    location:
                                        widget.githubJobsList[index].location ??
                                            "",
                                    type:
                                        widget.githubJobsList[index].type ?? "",
                                    imgUrl: widget.githubJobsList[index]
                                            .companyLogo ??
                                        "",
                                    title: widget.githubJobsList[index].title ??
                                        "",
                                    desc: widget.githubJobsList[index]
                                            .description ??
                                        "",
                                    posturl:
                                        widget.githubJobsList[index].url ?? "",
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobTile extends StatelessWidget {
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
  JobTile(
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
  Color mainColor = Color(0xff79fadb);
  @override
  Widget build(BuildContext context) {
    String descmarkdown = html2md.convert(desc);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GithubJobsDetails(
                      companyLogo: companyLogo,
                      companyName: companyName,
                      companyUrl: companyUrl,
                      // content: content,
                      desc: descmarkdown,
                      howToApply: howToApply,
                      imgUrl: imgUrl,
                      location: location,
                      posturl: posturl,
                      title: title,
                      type: type,
                    )));
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
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "(" + type + ")",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
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
