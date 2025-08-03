import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/view/address/widget/address_text_field.dart';


class UserLocationScreen extends StatelessWidget {
  final String lat;
  final String lang;


  const UserLocationScreen({
    super.key,
    required this.lat,
    required this.lang,
   
  });

  LatLng get customerLatLng => LatLng(double.parse(lat), double.parse(lang));

  Set<Marker> get customerMarker => {
        Marker(
          markerId: const MarkerId('customer_location'),
          position: customerLatLng,
          infoWindow: const InfoWindow(title: 'موقع العميل'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
             Padding(
              padding:const EdgeInsets.only(right: 8),
              child: Text('عنوان التوصيل',style: Styles.style1,),
            ),
           
            SizedBox(
              height: HelperFunctions.screenHeight() / 1.5,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: customerLatLng,
                  zoom: 15,
                ),
                markers: customerMarker,
                onMapCreated: (GoogleMapController mapController) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
