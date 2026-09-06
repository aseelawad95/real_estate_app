import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/responsiveExtension.dart';
import 'package:real_estate/features/home/presentation/widgets/custom_search.dart';
import 'package:real_estate/features/home/presentation/widgets/header_body.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/property/presentation/widgets/property_card.dart';
import 'package:real_estate/features/property/presentation/widgets/property_list.dart';
import 'package:real_estate/features/propertyType/presentation/bloc/property_type_cubit.dart';
import 'package:real_estate/features/propertyType/presentation/widgets/container_widget.dart';
import 'package:real_estate/service_locator.dart' show sl;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 17),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HeaderBody(),
                    SizedBox(height: context.h(25)),
                    SearchField(),
                    SizedBox(height: context.h(25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Property Type",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(text: "See all",color: AppColors.secondaryText,),
                      ],
                    ),
                    SizedBox(height: context.h(10)),
                    BlocProvider(
                      create: (_) =>
                          sl<PropertyTypeCubit>()..getAllPropertyTypes(),
                      child: ContainerWidget(),
                    ),
                    SizedBox(height: context.h(25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Featured Properties",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(text: "See all",color: AppColors.secondaryText,),
                      ],
                    ),
                    SizedBox(height: context.h(10)),
                    BlocProvider(
                       create: (_) =>
                          sl<GetpropertyCubit>()..getAllProperties(),
                      child: PropertyListPage(),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
