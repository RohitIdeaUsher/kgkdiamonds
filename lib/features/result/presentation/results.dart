import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kgkdiamonds/core/models/data.dart';
import 'package:kgkdiamonds/core/models/popup_model.dart';
import 'package:kgkdiamonds/core/widgets/app_popup.dart';
import 'package:kgkdiamonds/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:kgkdiamonds/features/result/presentation/cubit/result_cubit.dart';
import 'package:kgkdiamonds/features/result/presentation/cubit/result_state.dart';
import 'package:kgkdiamonds/features/result/presentation/widget/filter_button.dart';
import '../../../core/widgets/cart_icon.dart';
import '../../../core/widgets/diamond_tile.dart';

class Results extends StatelessWidget {
  const Results({super.key, this.filterData = const <DataModel>[]});
  final List<DataModel> filterData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultCubit(filterData, context.read<CartCubit>()),
      child: const ResultView(),
    );
  }
}

class ResultView extends StatefulWidget {
  const ResultView({
    super.key,
  });

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  void initState() {
    super.initState();
    context.read<ResultCubit>().getData(); // Triggers filtering
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return oldBody(context);
    return Scaffold(
        body: NestedScrollView(headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: true,
          // backgroundColor: ColorUtil.scaffoldBg,
          title: const Text("Results"),
          pinned: true,
          floating: true,
          forceElevated: innerBoxIsScrolled,
          actions: const [CartIcon()],
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterButton(
                        title: "Sort by Price",
                        onTapDown: (details) {
                          AppPopup.showPopupMenu(
                              context: context,
                              offset: details.globalPosition,
                              popupList: [
                                PopUpModel(
                                    iconData: Icons.attach_money_rounded,
                                    title: "Asc",
                                    onTap: context
                                        .read<ResultCubit>()
                                        .priceFilter),
                                PopUpModel(
                                    iconData: Icons.attach_money_rounded,
                                    title: "Desc",
                                    onTap: () => context
                                        .read<ResultCubit>()
                                        .priceFilter(asc: false)),
                              ]);
                        }),
                    FilterButton(
                        title: "Sort by Carat",
                        onTapDown: (details) {
                          AppPopup.showPopupMenu(
                              context: context,
                              offset: details.globalPosition,
                              popupList: [
                                PopUpModel(
                                    iconData: Icons.diamond,
                                    title: "Asc",
                                    onTap: context
                                        .read<ResultCubit>()
                                        .caratFilter),
                                PopUpModel(
                                    iconData: Icons.diamond,
                                    title: "Desc",
                                    onTap: () => context
                                        .read<ResultCubit>()
                                        .caratFilter(asc: false)),
                              ]);
                        }),
                  ],
                ),
              )),
        )
      ];
    }, body: BlocBuilder<ResultCubit, ResultCubitState>(
      builder: (context, state) {
        if (state is ResultCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ResultCubitLoaded) {
          final selectedDiamonds = state.selectedDiamonds;
          return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.filteredList.length,
              itemBuilder: (context, index) {
                final diamond = state.filteredList[index];
                final isSelected = selectedDiamonds.contains(diamond.lotID);
                return DiamondTile(
                  diamond: diamond,
                  onTap: () =>
                      context.read<ResultCubit>().toggleSelection(diamond),
                  selected: isSelected,
                );
              });
        }
        if (state is ResultCubitEmpty) {
          return Center(
            child: Text(
              state.message.toString(),
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is ResultCubitError) {
          return Center(
            child: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Container();
      },
    )));
  }

  Scaffold oldBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 40),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(
                      title: "Sort by Price",
                      onTapDown: (details) {
                        AppPopup.showPopupMenu(
                            context: context,
                            offset: details.globalPosition,
                            popupList: [
                              PopUpModel(
                                  iconData: Icons.attach_money_rounded,
                                  title: "Asc",
                                  onTap:
                                      context.read<ResultCubit>().priceFilter),
                              PopUpModel(
                                  iconData: Icons.attach_money_rounded,
                                  title: "Desc",
                                  onTap: () => context
                                      .read<ResultCubit>()
                                      .priceFilter(asc: false)),
                            ]);
                      }),
                  FilterButton(
                      title: "Sort by Carat",
                      onTapDown: (details) {
                        AppPopup.showPopupMenu(
                            context: context,
                            offset: details.globalPosition,
                            popupList: [
                              PopUpModel(
                                  iconData: Icons.diamond,
                                  title: "Asc",
                                  onTap:
                                      context.read<ResultCubit>().caratFilter),
                              PopUpModel(
                                  iconData: Icons.diamond,
                                  title: "Desc",
                                  onTap: () => context
                                      .read<ResultCubit>()
                                      .caratFilter(asc: false)),
                            ]);
                      }),
                ],
              ),
            )),
        actions: const [CartIcon()],
      ),
      body: BlocBuilder<ResultCubit, ResultCubitState>(
        builder: (context, state) {
          if (state is ResultCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ResultCubitLoaded) {
            final selectedDiamonds = state.selectedDiamonds;
            return ListView.builder(
                itemCount: state.filteredList.length,
                itemBuilder: (context, index) {
                  final diamond = state.filteredList[index];
                  final isSelected = selectedDiamonds.contains(diamond.lotID);
                  return DiamondTile(
                    diamond: diamond,
                    onTap: () =>
                        context.read<ResultCubit>().toggleSelection(diamond),
                    selected: isSelected,
                  );
                });
          }
          if (state is ResultCubitEmpty) {
            return Center(
              child: Text(
                state.message.toString(),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state is ResultCubitError) {
            return Center(
              child: Text(
                state.error.toString(),
                textAlign: TextAlign.center,
              ),
            );
          }
          return Container();
        },
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.arrow_upward),
      //         onPressed: () => context.read<ResultCubit>().priceFilter(),
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.arrow_downward),
      //         onPressed: () =>
      //             context.read<ResultCubit>().priceFilter(asc: false),
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.keyboard_arrow_up_rounded),
      //         onPressed: () => context.read<ResultCubit>().caratFilter(),
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.keyboard_arrow_down_rounded),
      //         onPressed: () =>
      //             context.read<ResultCubit>().caratFilter(asc: false),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
  /*

   
   */
}
