import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';
import 'package:real_estate/features/property/presentation/widgets/location_map.dart';

class MapPreview extends StatelessWidget {
  const MapPreview({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    final position = LatLng(location.latitude, location.longitude);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LocationMapScreen(location: location),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: AbsorbPointer(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: position,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('preview'),
                  position: position,
                ),
              },
              zoomControlsEnabled: false,
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              liteModeEnabled: true,
            ),
          ),
        ),
      ),
    );
  }
}