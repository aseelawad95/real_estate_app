// lib/features/search/presentation/pages/property_search_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/features/home/presentation/widgets/custom_search.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/property/presentation/widgets/property_list.dart';
import 'package:real_estate/features/search/presentation/widgets/show_property_filter_sheet.dart';
import 'package:real_estate/service_locator.dart' show sl;

class PropertySearchPage extends StatefulWidget {

  const PropertySearchPage({super.key, this.openFilterOnStart = false});
  final bool openFilterOnStart;

  @override
  State<PropertySearchPage> createState() => _PropertySearchPageState();
}

class _PropertySearchPageState extends State<PropertySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  late final GetpropertyCubit _propertyCubit;

  @override
  void initState() {
    super.initState();
    _propertyCubit = sl<GetpropertyCubit>()..getAllProperties();

    if (widget.openFilterOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showPropertyFilterSheet(context);
      });
    }
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final trimmed = value.trim();
      if (trimmed.isEmpty) {
        _propertyCubit.getAllProperties();
      } else {
        _propertyCubit.searchByKeyword(trimmed);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _propertyCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _propertyCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SearchField(
                        controller: _searchController,
                        onChanged: _onChanged,
                        hintText: "Search properties...",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () => showPropertyFilterSheet(context),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: PropertyListPage(
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(),
              ),
            ),
          );
        },
      ),
    );
  }
}
