import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/button/button_cubit.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_dropdown_textdield.dart';
import 'package:real_estate/common/widgets/custom_image_picker.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/common/widgets/custom_textfield.dart';
import 'package:real_estate/core/helper_function/TokenHelper.dart';
import 'package:real_estate/core/helper_function/responsiveExtension.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';
import 'package:real_estate/features/location/presentation/bloc/getlocation/getlocation_cubit.dart';
import 'package:real_estate/features/property/domain/entities/create_property.dart';
import 'package:real_estate/features/property/domain/usecase/create_property_usecase.dart';
import 'package:real_estate/features/property/presentation/widgets/location_bloc.dart';
import 'package:real_estate/features/property/presentation/widgets/property_type_bloc.dart';
import 'package:real_estate/features/propertyType/domain/entities/property_type.dart';
import 'package:real_estate/features/propertyType/presentation/bloc/property_type_cubit.dart';
import 'package:real_estate/service_locator.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  List<File> selectedImages = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ownerNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  PropertyType? _selectedPropertyType;
  Location? _selectedLocation;
   String? userId;
  bool isLoading = true;
  Key _propertyTypeKey = UniqueKey();
  Key _locationKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

 

  void _resetForm() {
    _titleController.clear();
    _bedroomsController.clear();
    _bathroomsController.clear();
    _areaController.clear();
    _priceController.clear();
    _ownerNumberController.clear();
    _descriptionController.clear();

    setState(() {
      selectedImages = [];
      _selectedPropertyType = null;
      _selectedLocation = null;
      _propertyTypeKey = UniqueKey();
      _locationKey = UniqueKey();
      selectedImages = [];
    });
  }


 Future<void> _loadUserId() async {
    final id = await TokenHelper.getUserId();

    setState(() {
      userId = id;
      isLoading = false;
    });
  }
  void _onCreatePressed(BuildContext context) {
    if (_selectedPropertyType == null || _selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار نوع العقار والموقع')),
      );
      return;
    }

    context.read<ButtonCubit>().excute(
      usecase: sl<CreatePropertyUseCase>(),
      params: CreatePropertyParams(
        ownerId: "04bd14dc-3217-447b-8d08-3e01edbfaf7f",
        translations: [
        TranslationParam(
          language: "ar",
          title:  _titleController.text,
          description:_descriptionController.text,
        ),
        TranslationParam(
          language: "en",
          title: _titleController.text,
          description: _descriptionController.text,
        ),
      ],
        bathrooms: int.tryParse(_bathroomsController.text) ?? 0,
        bedrooms: int.tryParse(_bedroomsController.text) ?? 0,
        listingType: "Sale",
        images: selectedImages.map((image) => image.path).toList(),
        area: int.tryParse(_areaController.text) ?? 0,
        price: double.tryParse(_priceController.text) ?? 0,
        ownerPhone: int.tryParse(_ownerNumberController.text) ?? 0,
        propertyTypeId: _selectedPropertyType!.id,
        locationId: _selectedLocation!.id,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _areaController.dispose();
    _priceController.dispose();
    _ownerNumberController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              _resetForm();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إنشاء العقار بنجاح')),
              );
            }
            if (state is ButtonFailureState) {
              print('Error: ${state.errorMessage}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.h(10)),
                  CustomText(
                    text: "Create Post",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(height: context.h(10)),
                  CustomTextField(
                    controller: _titleController,
                    hintText: "Title",
                    isPassword: false,
                    icon: CupertinoIcons.textformat,
                  ),
                  SizedBox(height: context.h(10)),
                  CustomTextField(
                    controller: _bedroomsController,
                    hintText: "Bedrooms",
                    isPassword: false,
                    icon: CupertinoIcons.bed_double,
                  ),
                  SizedBox(height: context.h(10)),
                  CustomTextField(
                    controller: _bathroomsController,
                    hintText: "Bathrooms",
                    isPassword: false,
                    icon: CupertinoIcons.drop,
                  ),
                  SizedBox(height: context.h(10)),
                  CustomTextField(
                    controller: _areaController,
                    hintText: "Area",
                    isPassword: false,
                    icon: CupertinoIcons.arrow_up_left_arrow_down_right,
                  ),
                  SizedBox(height: context.h(10)),
                  CustomTextField(
                    controller: _priceController,
                    hintText: "Price",
                    isPassword: false,
                    icon: CupertinoIcons.money_dollar,
                  ),
                  SizedBox(height: context.h(10)),
                  CustomTextField(
                    controller: _ownerNumberController,
                    hintText: "Owner Number",
                    isPassword: false,
                    icon: CupertinoIcons.phone,
                  ),
                  SizedBox(height: context.h(10)),
                  
                  CustomDropDownTextField(
                    hintText: "Listing Type",
                    icon: CupertinoIcons.keyboard,
                    items: ["Rent","Sale"],
                  onChanged: (value) {
                    
                  },
                  ),
                  BlocProvider(
                    key: _propertyTypeKey, 
                    create: (_) => sl<PropertyTypeCubit>()..getAllPropertyTypes(),
                    child: ProperyTypeBlocListener(
                      onSelected: (type) {
                        setState(() => _selectedPropertyType = type);
                      },
                    ),
                  ),
                  SizedBox(height: context.h(10)),
                  BlocProvider(
                    key: _locationKey, 
                    create: (_) => sl<GetlocationCubit>()..getAllLocations(),
                    child: LocationBlocBuilder(
                      onSelected: (location) {
                        setState(() => _selectedLocation = location);
                      },
                    ),
                  ),
                  SizedBox(height: context.h(10)),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: "Description",
                    isPassword: false,
                    height: 100,
                    isDescription: true,
                  ),
                  SizedBox(height: context.h(10)),
                  CustomMultiImagePicker(
                    initialImages: selectedImages,
                    label: "Property Images",
                    maxImages: 10,
                    onImagesPicked: (List<File> images) {
                      setState(() => selectedImages = images);
                    },
                  ),
                  SizedBox(height: context.h(20)),
                  Builder(
                    builder: (context) {
                      return BasicAppButton(
                        onPressed: () => _onCreatePressed(context),
                        title: "Create Post",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}