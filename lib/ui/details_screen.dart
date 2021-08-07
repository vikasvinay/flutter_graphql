import 'package:flutter/material.dart';
import 'package:flutter_task/model/mission.dart';
import 'package:flutter_task/utilities/color_palette.dart';
import 'package:flutter_task/utilities/images.dart';
import 'package:flutter_task/utilities/navigator_key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatefulWidget {
  final Mission mission;
  const DetailsScreen({Key? key, required this.mission}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      floatingActionButton: FloatingActionButton(
        heroTag: "mission-details",
        onPressed: () {
          NavigatorKey.navigatorKey.currentState!.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, val) {
          return [
            SliverAppBar(
              leading: Container(),
              backgroundColor: Palette.primary,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  double size = constraints.constrainHeight();

                  return FlexibleSpaceBar(
                    background: Transform.scale(
                      scale: size / (0.4.sh + kToolbarHeight),
                      child: Container(
                          padding: EdgeInsets.only(top: 20.h),
                          height: 0.4.sh,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text(
                                  widget.mission.missionName!,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.25.sh,
                                width: double.infinity,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(left: 30.w),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: widget.mission.images!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 30.w),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          child: Container(
                                              height: 0.2.sh,
                                              width: 0.8.sw,
                                              child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      LocalAssets.placeholder,
                                                  image: widget
                                                      .mission.images![index],
                                                  fit: BoxFit.cover)),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          )),
                    ),
                  );
                },
              ),
              expandedHeight: 0.5.sh,
            )
          ];
        },
        body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r))),
          child: Column(
            children: [
              Wrap(
                children: [
                  chipWithIcon(
                      width: 120.w,
                      icon: Image.asset(
                        LocalAssets.rocket,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                      text: widget.mission.rocketName!),
                  chipWithIcon(
                      width: 200.w,
                      icon: Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      text: widget.mission.launchDate!),
                  chipWithIcon(
                      width: 130.w,
                      text:
                          "Launch: ${widget.mission.launchSuccess! ? "Success" : "Fail"}")
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text(
                    "Location: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  Text(widget.mission.launchSiteName!)
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Launch Details: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.mission.details!,
                  textAlign: TextAlign.justify,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget chipWithIcon(
      {Widget? icon,
      required String text,
      Color? textColor,
      required double width}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 8),
      width: width,
      child: Chip(
          backgroundColor: Palette.primary,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon == null ? Container() : Container(height: 20.h, child: icon),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
