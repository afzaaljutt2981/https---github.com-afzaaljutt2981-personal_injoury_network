import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_geocoding/google_geocoding.dart' as gc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';

import '../../../global/utils/app_strings.dart';
import '../../../global/utils/constants.dart';
import '../../../global/utils/functions.dart';
import '../models/address_model.dart';

// ignore: must_be_immutable
class SelectLocation extends StatefulWidget {
  Color primary;
  final AddressModel? addressModel;

  SelectLocation({Key? key, required this.primary, this.addressModel})
      : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  CameraPosition position = const CameraPosition(
    target: LatLng(16.2623176, -61.5590584),
    zoom: 10.4746,
  );

  GoogleMapController? _controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  late double height, width;

  String searchResults = "Search Address";
  var controller = TextEditingController();

  String postalCode = "", city = "", country = "";

  @override
  void initState() {
    // _determinePosition();
    if (widget.addressModel != null) {
      var position = LatLng(widget.addressModel!.latitude ?? 37.42796133580664,
          widget.addressModel!.longitude ?? -122.085749655962);
      latLng = position;
      this.position = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
      country = widget.addressModel?.country ?? "";
      city = widget.addressModel?.city ?? "";
      postalCode = widget.addressModel?.postalCode ?? "";
      searchResults = widget.addressModel?.address ?? "";
      var markerIdVal = AppStrings.selectedLocation;
      final MarkerId markerId = MarkerId(markerIdVal);
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          latLng?.latitude ?? 37.42796133580664,
          latLng?.longitude ?? -122.085749655962,
        ),
        onTap: () {},
      );
      markers[markerId] = marker;
    }
    // <script src="hty=AIzaSyCgbyafbtB4jObI8SDH87HJ6N_96aTmyfQ"></script>

    super.initState();
  }

  bool fromPlaces = false;

  String? code;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              onCameraIdle: () {
                if (latLng != null) {
                  if (!fromPlaces) {
                    getAddress();
                  }
                  fromPlaces = false;
                  addMarker(latLng!);
                }
              },
              onCameraMove: (CameraPosition position) {
                latLng = position.target;
              },
              mapType: MapType.normal,
              initialCameraPosition: position,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              markers: Set<Marker>.of(markers.values),
            ),
            InkWell(
              onTap: () async {
                var p = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: Constants.mapKey,
                  onError: (error) {},
                  mode: Mode.overlay,
                  language: "en",
                  decoration: InputDecoration(
                    hintText: "Search",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  types: [],
                  strictbounds: false,
                  components: [
                    // Component(Component.country, "pk"),
                  ],
                );
                displayPrediction(p);
              },
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  // decoration: Constants.shadowDecoration(),
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: widget.primary,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Expanded(
                        child: Text(
                          searchResults,
                          style: TextStyle(
                            color: widget.primary,
                            fontSize: 16,
                            fontFamily: "jr",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: height * 0.015,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    if (latLng == null || searchResults == "Search Address") {
                      Functions.showSnackBar(
                          context, AppStrings.pleaseSelectALocationToContinue);
                    } else {
                      AddressModel model = AddressModel(
                        latitude: latLng!.latitude,
                        longitude: latLng!.longitude,
                        country: country,
                        city: city,
                        postalCode: postalCode,
                        address: searchResults,
                      );
                      Navigator.of(context).pop(model);
                    }
                  },
                  child: Text(
                    AppStrings.selectLocation,
                    style: const TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontFamily: "jr",
                      fontSize: 14,
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

  getAddress() async {
    var googleGeocoding = gc.GoogleGeocoding(Constants.mapKey);
    var l = gc.LatLon(latLng!.latitude, latLng!.longitude);
    gc.GeocodingResponse? result =
        await googleGeocoding.geocoding.getReverse(l);

    String address = "";
    searchResults = "";
    city = "";
    country = "";
    postalCode = "";
    if (result != null &&
        result.results != null &&
        result.results!.isNotEmpty) {
      var element = result.results![0];
      if (element.formattedAddress != null) {
        address = element.formattedAddress!;
      }
      if (element.addressComponents != null) {
        for (var element in element.addressComponents!) {
          if (element.types == null || element.longName == null) {
            return;
          }
          var types = element.types!;

          if (types.contains("locality")) {
            city = element.longName!;
          }
          if (types.contains('postalCode')) {
            postalCode = element.longName!;
          }
          if (types.contains(country)) {
            country = element.longName!;
          }
        }
      }

      setState(() {
        searchResults = address;
      });
    }
  }

  addMarker(LatLng model) {
    var markerIdVal = AppStrings.selectedLocation;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        model.latitude,
        model.longitude,
      ),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    markers[markerId] = marker;
    setState(() {});
  }

  LatLng? latLng;

  Future<void> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: Constants.mapKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      searchResults = "";
      city = "";
      country = "";
      postalCode = "";
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      var element = detail.result;
      for (var element in element.addressComponents) {
        var types = element.types;
        if (types.contains('locality')) {
          city = element.longName;
        }
        if (types.contains('postalCode')) {
          postalCode = element.longName;
        }
        if (types.contains('country')) {
          country = element.longName;
        }
      }
      fromPlaces = true;
      setState(() {
        searchResults = element.formattedAddress ?? "";
      });

      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;
      var position = LatLng(lat, lng);
      latLng = position;
      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.newLatLng(position));
      }
    }
  }
}
