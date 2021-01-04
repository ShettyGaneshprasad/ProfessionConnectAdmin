import 'dart:convert';

import 'package:ProfessionConnect/models/githubJobs.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class GithubJobs {
  List<GithubJobsModel> githubJobsList = [];

  Future<void> getNews() async {
    String url = "https://jobs.github.com/positions.json";
    print("before get url");
    var response = await http.get(url);
    print("after get url");
    var jsonData = jsonDecode(response.body);
    print("before jsondata status");

    jsonData.forEach((element) {
      // if (element["urlToImage"] != null &&
      //     element["description"] != null &&
      //     element["source"]["name"] == "CNN")
      print("getting job");
      GithubJobsModel githubJobsModel = GithubJobsModel(
        companyName: element['company'],
        description: element['description'],
        title: element['title'],
        url: element['url'],
        companyLogo: element['company_logo'],
        companyUrl: element['company_url'],
        howToApply: element['how_to_apply'],
        location: element['location'],
        id: element['id'],
        type: element['type'],
      );
      githubJobsList.add(githubJobsModel);
      githubJobsModel = null;
    });
  }
}
