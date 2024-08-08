import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/screens/input.dart';
import 'package:location_app/state/map_screen.dart';
import 'package:location_app/state/splash.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  bool isSelecting = false;
  bool response = false;
  String selectedAddress = 'Pick your Location';

  @override
  Widget build(BuildContext context) {
    final model =
        Provider.of<SplashScreenProvider>(context, listen: false).userLocation;
    return Scaffold(
      appBar: AppBar(
          title: Text(isSelecting ? 'Your Location' : selectedAddress),
          actions: [
            // if (isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                if (_pickedLocation != null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return  InputScreen(city: selectedAddress);
                  }));
                }else{
                  setState(() {
                    selectedAddress = 'Please Select Location';
                  });
                }
              },
            ),
          ]),
      body: GoogleMap(
        onTap: (position) async {
          setState(() {
            _pickedLocation = position;
            //isSelecting = true;
          });
          if (_pickedLocation != null) {
            try {
             final response = await Provider.of<MapProvider>(context, listen: false).fetchLocation(_pickedLocation!.latitude, _pickedLocation!.longitude);
              if (response.statusCode == 200) {
                final resData = jsonDecode(response.body);
                final address = resData['results'][0]['formatted_address'];
                //print(address);
               setState(() {
                 selectedAddress = address;
               });
              } 
              return response;
            } catch (e) {
             rethrow;
            }
          }
        },
        initialCameraPosition: CameraPosition(
          target: isSelecting
              ? _pickedLocation!
              : LatLng(
                  model.latitude,
                  model.longitude,
                ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        model.latitude,
                        model.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
