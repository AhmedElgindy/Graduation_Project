// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/view/presentations/Seat_screen/select_seat.dart';
import 'package:graduation/view/shared/component/constants.dart';

import 'package:graduation/view/shared/component/helperfunctions.dart';

import '../../shared/component/components.dart';

import 'cubit/ticket_cubit.dart';
import 'cubit/ticket_state.dart';

class Ticket extends StatefulWidget {
  const Ticket({
    super.key,
  });

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  late final FlightTicketCubit _flightTicketCubit;

  @override
  void initState() {
    super.initState();
    _flightTicketCubit = FlightTicketCubit();
    // ...
  }

  @override
  Widget build(BuildContext context) {
    final List<TicketData> tickets = [
      TicketData(
        passengerName: 'John Doe',
        flightNumber: 'ABC123',
        departureTime: '10:00 AM',
        arrivalTime: '12:00 PM',
        duration: '2 hours',
        seatNumber: '12A',
        seatClass: 'Economy',
        departure: 'New York',
        arrival: 'Los Angeles',
      )
    ];

    FlightTicketCubit.get(context).addTickets(tickets);

    return Scaffold(
      backgroundColor: const Color(0xc61859ba),
      appBar: AppBar(
        backgroundColor: const Color(0xc61859ba),
        centerTitle: true,
        title: const Text("Ticket"),
        leading: BackButton(
          onPressed: () => nextScreenRep(context, const SelectSeat()),
        ),
      ),
      body: BlocBuilder<FlightTicketCubit, FlightTicketState>(
        builder: (context, state) {
          if (FlightTicketCubit.get(context).tickets.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: FlightTicketCubit.get(context).tickets.length,
            itemBuilder: (BuildContext context, int index) {
              final ticket = FlightTicketCubit.get(context).tickets[index];
              return Column(
                children: <Widget>[
                  TicketShape(
                    arrivalTime: ticket.arrivalTime,
                    departureTime: ticket.departureTime,
                    duration: ticket.duration,
                    flightNumber: ticket.flightNumber,
                    passengerName: ticket.passengerName,
                    seatClass: ticket.seatClass,
                    seatNumber: ticket.seatNumber,
                    arrival: ticket.arrival,
                    departure: ticket.departure,
                  ),
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          FlightTicketCubit.get(context).removeTicket(index);
                        },
                        child: const Text('Delete it'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Code to run when the button is pressed
                        },
                        child: const Text('Download it'),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _flightTicketCubit.close();
    super.dispose();
  }
}

// class Ticket extends StatelessWidget {
//   const Ticket({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xc61859ba),
//       appBar: AppBar(
//         backgroundColor: const Color(0xc61859ba),
//         centerTitle: true,
//         title: const Text("Ticket"),
//         leading: BackButton(
//           onPressed: () => nextScreenRep(context, const SelectSeat()),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: 3,
//         itemBuilder: (BuildContext context, int index) {
//           return Column(children: <Widget>[
//             const Center(
//               child: TicketShape(
//                 arrivalTime: '',
//                 departureTime: '',
//                 duration: '',
//                 flightNumber: '',
//                 passengerName: '',
//                 seatClass: '',
//                 seatNumber: '',
//                 arrival: '',
//                 departure: '',
//               ),
//             ),
//           ]);
//         },
//       ),
//     );
//   }
// }

class TicketShape extends StatelessWidget {
  final String? passengerName;
  final String? flightNumber;
  final String? departureTime;
  final String? arrivalTime;
  final String? duration;
  final String? seatNumber;
  final String? seatClass;
  final String? departure;
  final String? arrival;
  const TicketShape({
    super.key,
    required this.passengerName,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.seatNumber,
    required this.seatClass,
    required this.departure,
    required this.arrival,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Card(
        elevation: 8,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FromToShape(
                arrival: arrival,
                departure: departure,
              ),
              const SizedBox(height: 30),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Passenger Name',
                      style: Styles.headLinestyle3,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Ahmed Mousa Abdullaha',
                      style: Styles.headLinestyle2,
                    ),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Flight No',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'XC6569',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Duration',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '2:15',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Departure Time',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '3/7/2023 3:20',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Arrival Time',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '3/7/2023 5:35',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Seat No',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '34A',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Class',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Business',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                  ]),

              const SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Image.asset('assets/images/barcode.jpg')),

              /// after line (second part)
              const SizedBox(height: 20),
              const DotedWidget(
                color: Color.fromARGB(255, 105, 116, 235),
                section: 10,
                width: 6,
              ),

              ///airplane and frm to shape
              const SizedBox(height: 20),
              FromToShape(
                arrival: arrival,
                departure: departure,
              ),
              const SizedBox(height: 20),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Passenger Name',
                      style: Styles.headLinestyle3,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Ahmed Mousa Abdullaha',
                      style: Styles.headLinestyle2,
                    ),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Flight No',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'XC6569',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Seat No',
                            style: Styles.headLinestyle3,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '34A',
                            style: Styles.headLinestyle2,
                          ),
                        ]),
                  ]),
            ],
          ),
        ),
      ),
      // Flex(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   direction: Axis.horizontal,
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         // Code to run when the button is pressed
      //       },
      //       child: const Text('Delete it'),
      //     ),
      //     const SizedBox(width: 20),
      //     ElevatedButton(
      //       onPressed: () {
      //         // Code to run when the button is pressed
      //       },
      //       child: const Text('Downlaod it'),
      //     )
      //   ],
      // )
    ]);
  }
}

class FromToShape extends StatelessWidget {
  final String? departure;
  final String? arrival;
  const FromToShape({
    super.key,
    required this.departure,
    required this.arrival,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "LHD",
            style: Styles.headLinestyle2.copyWith(color: Styles.textColor),
          ),
        ),
        const ThickContainer(
          iscolor: true,
        ),
        Expanded(
          child: Stack(
            children: [
              const SizedBox(
                height: 24,
                child: DotedWidget(
                  color: Color.fromARGB(255, 105, 116, 235),
                  section: 6,
                  width: 4,
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: 1.5,
                  child: const Icon(
                    Icons.airplanemode_on_outlined,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        const ThickContainer(
          iscolor: true,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "CIR",
            style: Styles.headLinestyle2.copyWith(color: Styles.textColor),
          ),
        ),
      ],
    );
  }
}
