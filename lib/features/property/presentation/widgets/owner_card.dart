import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/message/presentation/pages/message_page.dart';
import 'package:real_estate/features/property/domain/entities/owner.dart';
import 'package:real_estate/features/property/presentation/widgets/circle_icon_button.dart';

class OwnerCard extends StatelessWidget {
  const OwnerCard({super.key, required this.owner, required this.propertyId});
  final Owner owner;
  final int propertyId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.textFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                CustomText(
                  text: owner.name,
                  color: AppColors.textColor,
                  fontSize: 12,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // ...List.generate(5, (i) {
                    //   final filled = i < owner.rating.round();
                    //   return Icon(
                    //     filled ? Icons.star : Icons.star_border,
                    //     size: 13,
                    //     color: AppColors.secondaryColor,
                    //   );
                    // }),
                    const SizedBox(width: 4),
                    CustomText(
                      text: '(${owner.phone})',
                      color: AppColors.primaryColor,
                      fontSize: 11,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleIconButton(
            icon: Icons.message,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MessagePage(
                receiverId: owner.ownerId!,
              ownerName: owner.name,
              propertyId:propertyId,
              conversationId:null ,
              )));
            },
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:real_estate/features/location/domain/entities/location.dart';
// import 'package:real_estate/features/property/presentation/widgets/location_map.dart';

// class MapPreview extends StatelessWidget {
//   const MapPreview({super.key, required this.location});

//   final Location location;

//   @override
//   Widget build(BuildContext context) {
//     final position = LatLng(location.latitude, location.longitude);

//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => LocationMapScreen(location: location),
//         ),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: SizedBox(
//           height: 140,
//           width: double.infinity,
//           child: AbsorbPointer(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: position,
//                 zoom: 15,
//               ),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId('preview'),
//                   position: position,
//                 ),
//               },
//               liteModeEnabled: true,
//               zoomControlsEnabled: false,
//               scrollGesturesEnabled: false,
//               rotateGesturesEnabled: false,
//               tiltGesturesEnabled: false,
//               zoomGesturesEnabled: false,
//               myLocationButtonEnabled: false,
//               myLocationEnabled: false,
//               compassEnabled: false,
//               mapToolbarEnabled: false,
//               buildingsEnabled: false,
//               trafficEnabled: false,
//               indoorViewEnabled: false,
//               mapType: MapType.normal,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
