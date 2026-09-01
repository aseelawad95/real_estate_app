import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/search/presentation/widgets/listing_type.dart';
import 'package:real_estate/service_locator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomScrollView(
            slivers: [
               SliverToBoxAdapter(
                child:  CustomText(
                text: "Find Your Property",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
               ),
              SliverToBoxAdapter(
                child: BlocProvider(
                  create: (_) => sl<GetpropertyCubit>()..getAllProperties(),
                  child: ListingType(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
