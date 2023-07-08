import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/My_Trips/cubit/mytrips_cubit.dart';

import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_cubit.dart';
import 'package:graduation/view/presentations/Seat_screen/select_seat.dart';
import 'package:graduation/view/presentations/auth/cubit/auth_cubit.dart';
import 'package:graduation/view/presentations/auth/login/login_screen.dart';
import 'package:graduation/view/presentations/find_ticket/cubit/find_ticket_cubit.dart';

import 'package:graduation/view/presentations/ticket/cubit/ticket_cubit.dart';

import 'package:graduation/view/shared/component/constants.dart';

import 'view/shared/network/local/cach_helper.dart';

void main() {
  CacheHelper.init();
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => SearchCubit())),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: ((context) => FlightTicketCubit())),
        BlocProvider(create: ((context) => PersonTripsCubit())),
        BlocProvider(create: ((context) => FindTicketCubit())),
        BlocProvider(create: ((context) => SeatCubit())),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primarycolor,
        ),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: LoginHome(),
      ),
    );
  }
}
