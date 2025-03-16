import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kgkdiamonds/core/constant/app_images.dart';
import 'package:kgkdiamonds/core/widgets/cart_icon.dart';
import 'package:kgkdiamonds/features/filter/presentation/cubit/filter_cubit.dart';
import 'package:kgkdiamonds/features/filter/presentation/cubit/filter_state.dart';
import 'package:kgkdiamonds/features/result/presentation/results.dart';

import '../../../core/common_cubit/diamonds/diamonds_cubit.dart';
import '../../../core/widgets/common_button.dart';
import 'widget/carat_filter_widget.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(context.read<DiamondsCubit>()),
      child: const FiterView(),
    );
  }
}

class FiterView extends StatefulWidget {
  const FiterView({super.key});

  @override
  State<FiterView> createState() => _FiterViewState();
}

class _FiterViewState extends State<FiterView> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(AppImages.APPLGOG),
        title: const Text("Filter"),
        actions: const [CartIcon()],
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          if (state is FilterInitial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final filterCubit = context.read<FilterCubit>();

            return GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: ListView(
                children: [
                  CaratFilterWidget(
                    fromController: fromController,
                    toController: toController,
                    onCaratSelected: (from, to) {
                      context.read<FilterCubit>().updateSelectedFilter(
                          caratFrom: from, caratTo: to, fromInput: true);
                    },
                  ),
                  _buildFilterSection(
                      context, "Lab", filterCubit.lab, filterCubit.selectedLab,
                      (value) {
                    filterCubit.updateSelectedFilter(lab: value);
                  }),
                  _buildFilterSection(context, "Shape", filterCubit.shape,
                      filterCubit.selectedShape, (value) {
                    filterCubit.updateSelectedFilter(shape: value);
                  }),
                  _buildFilterSection(context, "Color", filterCubit.color,
                      filterCubit.selectedColor, (value) {
                    filterCubit.updateSelectedFilter(color: value);
                  }),
                  _buildFilterSection(context, "Clarity", filterCubit.clarity,
                      filterCubit.selectedClarity, (value) {
                    filterCubit.updateSelectedFilter(clarity: value);
                  }),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar:
          BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
        if (state is FilterInitial) {
          return const SizedBox();
        } else {
          if (state is FilterUpdated) {
            bool enableFilter = state.filteredList.isNotEmpty;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              child: Row(
                children: [
                  Text("${state.filteredList.length} results found."),
                  const Spacer(),
                  CommonButton(
                    onClick: enableFilter
                        ? () {
                            fromController.clear();
                            toController.clear();
                            context.read<FilterCubit>().resetFilters();
                          }
                        : null,
                    title: "Reset",
                  ),
                  SizedBox(width: 8.w),
                  CommonButton(
                    onClick: enableFilter
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Results(
                                          filterData: state.filteredList,
                                        )));
                          }
                        : null,
                  ),
                ],
              ),
            );
          }
          if (state is FilterEmpty) {}

          return const SizedBox();
        }
      }),
    );
  }

  Widget _buildFilterSection(BuildContext context, String title,
      Set<dynamic> allData, Set<dynamic> selectedData, Function(dynamic) onTap,
      {Widget? midWidget}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          if (midWidget != null) midWidget,
          Wrap(
            spacing: 8.w,
            children: allData.map((item) {
              final isSelected = selectedData.contains(item);
              return GestureDetector(
                onTap: () => onTap(item),
                child: Chip(
                  label: Text(
                    item.toString(),
                    style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black),
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                        color:
                            isSelected ? Colors.black : Colors.grey.shade400),
                  ),
                  backgroundColor:
                      isSelected ? Colors.grey.shade400 : Colors.white,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
