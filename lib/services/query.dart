class Myquery {
  String sortBy(String queryType) {
    return '''query data {launches(limit: 10, sort: "$queryType") {mission_name launch_date_unix details details launch_success links{mission_patch flickr_images} rocket {rocket_name} launch_site{site_name}}}''';
  }

  String getMission(String missionName) {
    return '''query data {launches(find: {mission_name: "$missionName"}limit: 10) {mission_name launch_date_unix details details launch_success links{mission_patch flickr_images} rocket {rocket_name} launch_site{site_name}}}''';
  }

  String getAll() {
    return "query data {launches(limit: 10) {mission_name launch_date_unix details details launch_success links{mission_patch flickr_images} rocket {rocket_name} launch_site{site_name}}}";
  }
}













// {
//   launches(limit: 10, sort: "mission_name") {
//     mission_name
//     launch_date_utc
//     links {
//       mission_patch 
//       flickr_images
//     }
//     details
//     launch_success
//     rocket {
//       rocket_name
//     }
//     launch_site {
//       site_name
//     }
//   }
// }
