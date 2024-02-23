import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:presensi/app/routes/app_pages.dart';
import 'package:presensi/utils/app.fonts.dart';
import 'package:presensi/utils/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as ll;
import 'package:permission_handler/permission_handler.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isShow = false;
  bool isLoad = false;
  bool isMaps = false;

  final search = TextEditingController();

  final controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: AppFonts.poppins(
                fontSize: 16, color: blackColor, fontWeight: FontWeight.bold),
          ),
          shadowColor: Colors.transparent,
          backgroundColor: whiteColor,
          actions: [
            IconButton(
                onPressed: () {
                  showPopupMenu(context);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: blackColor,
                ))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                height: isShow == true ? 220 : 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hi Welcome",
                          style: AppFonts.poppins(
                              fontSize: 14,
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          "images/hello.png",
                          height: 20,
                        )
                      ],
                    ),
                    isShow == true
                        ? const SizedBox(
                            height: 8,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.fastOutSlowIn,
                      child: Visibility(
                          visible: isShow,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: whiteColor,
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Latitude : ",
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: whiteColor),
                                  ),
                                  Text(
                                    locationData != null
                                        ? "${locationData!.latitude}"
                                        : "Not Available",
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: whiteColor),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Longitude : ",
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: whiteColor),
                                  ),
                                  Text(
                                    locationData != null
                                        ? "${locationData!.longitude}"
                                        : "Not Available",
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: whiteColor),
                                  ),
                                ],
                              ),
                              Divider(
                                color: whiteColor,
                                height: 10,
                              ),
                              Text(
                                "Your Address : ",
                                style: AppFonts.poppins(
                                    fontSize: 12,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                placemark != null
                                    ? "${placemark![0].street}, ${placemark![0].locality}, ${placemark![0].subLocality}, ${placemark![0].country}"
                                    : "Not Available",
                                style: AppFonts.poppins(
                                    fontSize: 12, color: whiteColor),
                              ),
                            ],
                          )),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                        getPermission();
                      },
                      child: Container(
                        height: 34,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor.withOpacity(0.3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              isShow == true
                                  ? "Hide your location >>"
                                  : "Tap to view your location >>",
                              style: AppFonts.poppins(
                                  fontSize: 12, color: whiteColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  "Search Destination Location",
                  style: AppFonts.poppins(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: search,
                        style:
                            AppFonts.poppins(fontSize: 12, color: blackColor),
                        decoration: InputDecoration(
                          hintText: "Search for destination location",
                          isDense: true,
                          hintStyle: AppFonts.poppins(
                              fontSize: 12, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                        ),
                        onChanged: (value) async {
                          controller.isLoading.value = true;
                          var data = await addressSuggestion(value);
                          if (data.isNotEmpty) {
                            controller.listSource.value = data;
                            var url = Uri.parse(
                                'http://router.project-osrm.org/route/v1/driving/${locationData!.longitude},${locationData!.latitude};${dLoc!.longitude},${dLoc!.latitude}?steps=true&annotations=true&geometries=geojson&overview=full');
                            var response = await http.get(url);

                            print("response api : ${response.body}");
                            setState(() {
                              routpoints = [];
                              var route = jsonDecode(response.body)['routes'][0]
                                  ['geometry']['coordinates'];
                              for (int i = 0; i < route.length; i++) {
                                var reep = route[i].toString();
                                reep = reep.replaceAll("[", "");
                                reep = reep.replaceAll("]", "");
                                var lat1 = reep.split(',');
                                var long1 = reep.split(",");
                                routpoints.add(ll.LatLng(double.parse(lat1[1]),
                                    double.parse(long1[0])));
                              }
                              isVisible = !isVisible;
                              print("routes point : $routpoints");
                            });
                          }
                          controller.isLoading.value = false;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var geo = await showSimplePickerLocation(
                            context: context,
                            isDismissible: true,
                            zoomOption: const ZoomOption(
                                stepZoom: 3,
                                initZoom: 13,
                                maxZoomLevel: 19,
                                minZoomLevel: 3),
                            initCurrentUserPosition: const UserTrackingOption(
                                enableTracking: true, unFollowUser: true));
                        if (geo != null) {
                          Get.snackbar("Geo", geo.toString());
                          var latLng = LatLng(geo.latitude, geo.longitude);
                          setState(() {
                            dLoc = latLng;
                          });

                          var url = Uri.parse(
                              'http://router.project-osrm.org/route/v1/driving/${locationData!.longitude},${locationData!.latitude};${dLoc!.longitude},${dLoc!.latitude}?steps=true&annotations=true&geometries=geojson&overview=full');
                          var response = await http.get(url);

                          print("response api : ${response.body}");
                          setState(() {
                            routpoints = [];
                            var route = jsonDecode(response.body)['routes'][0]
                                ['geometry']['coordinates'];
                            for (int i = 0; i < route.length; i++) {
                              var reep = route[i].toString();
                              reep = reep.replaceAll("[", "");
                              reep = reep.replaceAll("]", "");
                              var lat1 = reep.split(',');
                              var long1 = reep.split(",");
                              routpoints.add(ll.LatLng(double.parse(lat1[1]),
                                  double.parse(long1[0])));
                            }
                            isVisible = !isVisible;
                            print("routes point : $routpoints");
                          });
                        }
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.indigo),
                        child: Center(
                          child: Icon(
                            Icons.location_on_sharp,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        ),
                      )
                    : SizedBox(
                        height:
                            controller.listSource.isEmpty || search.text.isEmpty
                                ? 0
                                : 100,
                        child: controller.listSource.isEmpty ||
                                search.text.isEmpty
                            ? Container()
                            : ListView.builder(
                                itemCount: controller.listSource.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: ListTile(
                                      onTap: () async {
                                        Get.snackbar(
                                            "Success get location",
                                            controller.listSource[index].point
                                                .toString());
                                        var geo =
                                            controller.listSource[index].point;
                                        var latLng = LatLng(
                                            geo!.latitude, geo.longitude);
                                        setState(() {
                                          dLoc = latLng;
                                          controller.listSource.clear();
                                          search.clear();
                                        });

                                        var url = Uri.parse(
                                            'http://router.project-osrm.org/route/v1/driving/${locationData!.longitude},${locationData!.latitude};${dLoc!.longitude},${dLoc!.latitude}?steps=true&annotations=true&geometries=geojson&overview=full');
                                        var response = await http.get(url);

                                        print(
                                            "response api : ${response.body}");
                                        setState(() {
                                          routpoints = [];
                                          var route = jsonDecode(
                                                  response.body)['routes'][0]
                                              ['geometry']['coordinates'];
                                          for (int i = 0;
                                              i < route.length;
                                              i++) {
                                            var reep = route[i].toString();
                                            reep = reep.replaceAll("[", "");
                                            reep = reep.replaceAll("]", "");
                                            var lat1 = reep.split(',');
                                            var long1 = reep.split(",");
                                            routpoints.add(ll.LatLng(
                                                double.parse(lat1[1]),
                                                double.parse(long1[0])));
                                          }
                                          isVisible = !isVisible;
                                          print("routes point : $routpoints");
                                        });
                                      },
                                      leading: Icon(
                                        Icons.pin_drop,
                                        color: blackColor,
                                      ),
                                      title: Text(
                                        controller.listSource[index].address
                                            .toString(),
                                        style: AppFonts.poppins(
                                            fontSize: 12, color: blackColor),
                                      ),
                                    ),
                                  );
                                },
                              )),
              ),
              locationData != null
                  ? Container(
                      height: 500,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      color: Colors.grey,
                      child: Visibility(
                          visible: locationData != null,
                          child: fm.FlutterMap(
                            options: fm.MapOptions(
                              center: ll.LatLng(locationData!.latitude!,
                                  locationData!.longitude!),
                              zoom: 15,
                            ),
                            nonRotatedChildren: [
                              fm.AttributionWidget.defaultWidget(
                                  source: 'OpenStreetMap contributors',
                                  onSourceTapped: null),
                            ],
                            children: [
                              fm.TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              fm.MarkerLayer(
                                markers: [
                                  fm.Marker(
                                    point: ll.LatLng(locationData!.latitude!,
                                        locationData!.longitude!),
                                    width: 100,
                                    height: 100,
                                    builder: (context) {
                                      return const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 50,
                                      );
                                    },
                                  ),
                                  if (dLoc != null)
                                    fm.Marker(
                                      point: ll.LatLng(
                                          dLoc!.latitude, dLoc!.longitude),
                                      width: 100,
                                      height: 100,
                                      builder: (context) {
                                        return const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: 50,
                                        );
                                      },
                                    )
                                ],
                              ),
                              fm.PolylineLayer(
                                polylineCulling: false,
                                polylines: [
                                  fm.Polyline(
                                      points: routpoints,
                                      color: Colors.blue,
                                      strokeWidth: 8)
                                ],
                              )
                            ],
                          )),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.indigo,
                      ),
                    ),
            ],
          ),
        ));
  }

  //get lat long user now
  loc.LocationData? locationData;
  //confert latlong to address
  List<Placemark>? placemark;
  //get latlong destination location
  LatLng? dLoc;

  //list location to polyline
  List<ll.LatLng> routpoints = [];

  bool isVisible = false;

  void getPermission() async {
    if (await Permission.location.isGranted) {
      getLocation();
      getAddress();
    } else {
      Permission.location.request();
    }
  }

  void getLocation() async {
    setState(() {
      isLoad = true;
    });
    locationData = await loc.Location.instance.getLocation();
    setState(() {
      isLoad = false;
    });
  }

  void getAddress() async {
    placemark = await placemarkFromCoordinates(
        locationData!.latitude!, locationData!.longitude!);
  }

  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 50, // right
        50,
        0,
        0,
      ),
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.account_box_rounded,
                color: blackColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                "My Profile",
                style: AppFonts.poppins(fontSize: 12, color: blackColor),
              ),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: blackColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                "Sign Out",
                style: AppFonts.poppins(fontSize: 12, color: blackColor),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        if (value == 1) {
          FirebaseAuth.instance.signOut();
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Get.toNamed(Routes.PROFILE);
        }
      }
    });
  }
}
