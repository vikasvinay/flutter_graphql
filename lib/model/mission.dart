import 'package:intl/intl.dart';

import '../utilities/constants.dart';

class Mission {
  bool? launchSuccess;
  String? details;
  String? missionName;
  String? launchSiteName;
  String? launchDate;
  String? rocketName;
  String? image;
  List? images;

  Mission(
      {this.details,
      this.launchDate,
      this.launchSiteName,
      this.launchSuccess,
      this.missionName,
      this.image,
      this.images,
      this.rocketName});

  factory Mission.fromJson({required Map<String, dynamic> data}) {
    int unix = data['launch_date_unix'];
    var format = DateFormat('MM/dd/yyyy, hh:mm a');
    var dateLocal =
        format.format(DateTime.fromMillisecondsSinceEpoch(unix * 1000));

    return Mission(
        details: data['details'] ?? "no data",
        launchSiteName: data['launch_site']['site_name'] ?? 'no data',
        launchSuccess: data['launch_success'] ?? false,
        missionName: data['mission_name'] ?? 'no data',
        rocketName: data['rocket']['rocket_name'],
        image: data['links']['mission_patch'] ?? defaultImage,
        images: data['links']['flickr_images'].length == 0
            ? [defaultImage]
            : data['links']['flickr_images'] as List,
        launchDate: dateLocal.toString());
  }
}
