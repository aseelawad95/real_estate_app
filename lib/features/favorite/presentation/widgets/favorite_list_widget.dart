import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/features/favorite/presentation/bloc/getFavoriteUser/get_favorite_user_cubit.dart';
import 'package:real_estate/features/favorite/presentation/widgets/favorite_property_card.dart';

class FavoriteListWidget extends StatefulWidget {
  final String userId;

  const FavoriteListWidget({super.key, required this.userId});

  @override
  State<FavoriteListWidget> createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends State<FavoriteListWidget> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavoriteUserCubit, GetFavoriteUserState>(
      builder: (context, state) {
        if (state is GetFavoriteUserLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetFavoriteUserError) {
          return SizedBox(
            height: 200,
            child: Center(
              child: CustomText(
                text: state.message,
                color: Colors.red,
              ),
            ),
          );
        }

        if (state is GetFavoriteUserLoaded) {
          final favorites = state.favorites;

          if (favorites.isEmpty) {
            return const SizedBox(
              height: 200,
              child: Center(child: Text("No Favorites found")),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: favorites.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final favorite = favorites[index];

              return FavoritePropertyCard(
                imageUrl: favorite.propertyImageUrl ?? '',
                price: '\$${favorite.propertyPrice.toStringAsFixed(0)}',
                location: favorite.propertyTitle ?? '',
                isVerified: true,
                isFavorite: true,
                onFavoriteTap: () {
                  // نداء cubit للحذف من المفضلة
                  // context.read<GetFavoriteUserCubit>().removeFavorite(favorite.id);
                },
                onTap: () {
                  // التنقل لتفاصيل العقار
                  // Navigator.pushNamed(context, '/property-details', arguments: favorite.propertyId);
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}