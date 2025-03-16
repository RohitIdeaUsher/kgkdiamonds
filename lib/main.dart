import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kgkdiamonds/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:kgkdiamonds/features/splash/presentation/splash.dart';
import 'core/common_cubit/diamonds/diamonds_cubit.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => DiamondsCubit()),
    BlocProvider(create: (context) => CartCubit()),
  ], child: const KGKDiamonds()));
}

class KGKDiamonds extends StatelessWidget {
  const KGKDiamonds({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xFF344444),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, primary: const Color(0xFF344444)),
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
