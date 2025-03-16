import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kgkdiamonds/core/widgets/diamond_tile.dart';
import 'package:kgkdiamonds/features/cart/presentation/cubit/cart_cubit.dart';

import 'cubit/cart_state.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.cartList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      size: 100.h,
                    ),
                    Text("Add items to your cart",
                        style: TextStyle(fontSize: 18.sp))
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartList.length,
                    itemBuilder: (context, index) {
                      final diamond = state.cartList[index];
                      return DiamondTile(
                        diamond: diamond,
                        selected: true,
                        onTap: () {
                          context
                              .read<CartCubit>()
                              .removeFromCart(diamond.lotID ?? 0);
                        },
                      );
                    },
                  ),
                ),
                // if (state.cartList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cart Summary (${state.cartList.length} Items)",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700)),
                          Text("Price(\$)",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w700))
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _commonSummerText(
                          "Average Discount", state.summary.avgDiscount),
                      _commonSummerText(
                          "Average Price", state.summary.avgPrice),
                      _commonSummerText(
                          "Total Carat", state.summary.totalCarat),
                      _commonSummerText(
                          "Total Price", state.summary.totalPrice),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Row _commonSummerText(String text, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$text:", style: TextStyle(fontSize: 18.sp)),
        Text("\$${value.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
