import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'extentions.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
    title: "Home",
    home: const Home(),
    theme: ThemeData(fontFamily: 'Poppins'),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  bool card = true;
  Color warna = '#ffffff'.toColor();
  Widget box({width: 100.0, height: 100.0}) => Container(
        width: width,
        height: height,
        color: Colors.grey,
      );

  int selectedCard = -1;

  void _ubahWarna(int indexActiveCard) {
    setState(() {
      if (indexActiveCard == selectedCard) {
        // toggle border
        selectedCard = -1;
      } else {
        selectedCard = indexActiveCard;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    getCurrentLocation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildTopBar() {
    return Wrap(
      children: [
        Container(
          // height: 247.0,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 20.0)],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0))),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    // horizontal: 10,
                    ),
                child: Row(
                  children: [
                    Image.asset("img/profile.png"),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Gandi Subara",
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
                        Text(
                          "Fasilkom",
                          style: TextStyle(color: Colors.black, fontSize: 10.0),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    //  Image.asset(
                    //   "img/logo.png",
                    //   fit: BoxFit.contain,
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  // style: TextStyle(color: Colors.pinkAccent, height:
                  //     MediaQuery.of(context).size.height/80),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      prefixIcon: Image.asset(
                        "img/titikJemput.png",
                      ),
                      hintText: "Titik Jemput",
                      fillColor: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      prefixIcon: Image.asset(
                        "img/tujuan.png",
                      ),
                      hintText: "Lokasi Tujuan",
                      fillColor: Colors.white70),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: 270.0,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 40.0)],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _ubahWarna(0);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: selectedCard == 0
                              ? '#33BC51'.toColor()
                              : "#EBEFED".toColor(),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [Image.asset("img/motor.png"), Text("Motor")],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _ubahWarna(1);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: selectedCard == 1
                              ? '#33BC51'.toColor()
                              : "#EBEFED".toColor(),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Image.asset("img/makanan.png"),
                          Text("Makanan")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _ubahWarna(2);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: selectedCard == 2
                              ? '#33BC51'.toColor()
                              : "#EBEFED".toColor(),
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Image.asset("img/pesanAntar.png"),
                          Text("Pesan Antar")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300.0,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(), backgroundColor: '#F3C703'.toColor()),
              child: const Text("Pesan Sekarang"),
              onPressed: (() => context),
            ),
          )
        ],
      ),
    );
    //
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
    location.onLocationChanged.listen((newLoc) {
      setState(() {
        currentLocation = newLoc;
      });
    });
  }

  Widget buildMapBackground() {
    return currentLocation == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
              zoom: 16.5,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("currentLocation"),
                position: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            // background / map
            buildMapBackground(),
            // bar atas
            buildTopBar(),
            // kamu mau pergi
            Align(
              alignment: Alignment.bottomCenter,
              child: buildBottomBar(),
            ),

            // bottom bar
            Align(
              alignment: Alignment.bottomCenter,
              child: buildBottomBar(),
            ),
            // bottom navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomNavBar(),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
          color: '#EBEFED'.toColor(),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))),
      child: TabBar(
        controller: controller,
        tabs: [
          Tab(
              icon: Image.asset(
                "img/home.png",
                color: '#F3C703'.toColor(),
              ),
              child: Text(
                "Beranda",
                style: TextStyle(color: '#1E1E1E'.toColor()),
              )),
          Tab(
              icon: Image.asset(
                "img/book.png",
              ),
              child: Text(
                "Riwayat",
                style: TextStyle(color: '#1E1E1E'.toColor()),
              )),
          Tab(
              icon: Image.asset(
                "img/menu.png",
              ),
              child: Text(
                "Menu",
                style: TextStyle(color: '#1E1E1E'.toColor()),
              )),
        ],
      ),
    );
  }
}
