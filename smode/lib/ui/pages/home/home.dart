// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smode/blocs/auth/auth_bloc.dart';
import 'package:smode/blocs/vehicle/vehicle_bloc.dart';
import 'package:smode/models/vehicle_model.dart';
import 'package:smode/shared/shared_methods.dart';
import 'package:smode/ui/widgets/lacak_motor.dart';
import 'package:smode/ui/widgets/panduan.dart';
import 'package:smode/ui/widgets/riwayat_deteksi.dart';
import 'dart:async';
// import 'package:smode/shared/shared_methods.dart';


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smode/blocs/auth/auth_bloc.dart';
// import 'package:smode/blocs/vehicle/vehicle_bloc.dart';
// import 'package:smode/models/vehicle_model.dart';
// import 'package:smode/shared/shared_methods.dart';
// import 'package:smode/ui/widgets/panduan.dart';
// import 'package:smode/ui/widgets/riwayat_deteksi.dart';
// import 'package:smode/ui/widgets/lacak_motor.dart';

// import 'package:dropdown_button2/dropdown_button2.dart';

class HomePage extends StatefulWidget {
  // final String id;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  VehicleModel? motor;
  String? merkMotor;
  Timer? _timer;
bool? isModeAman;



  // void initState() {
  //   super.initState();
  //   _timer = Timer.periodic(Duration(seconds: 5), (timer) {
  //     _refreshData(); // Memanggil fungsi refresh setiap 5 detik
  //   });
  // }

  // void _startTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 5), (timer) {
  //     _refreshData(); // Memanggil fungsi refresh setiap 5 detik
  //   });
  // }

  // Future<void> _refreshData() async {
    
  //   // BlocProvider.of<VehicleBloc>(context).add(VehicleGet());
  // }

  // @override
  // Stream<VehicleBloc> mapEventToState(VehicleEvent event) async* {
  //   if (event is RefreshCurrentModeEvent) {
  //     // Logika untuk mendapatkan state terbaru (jika perlu)
  //     yield state; // Kembalikan state yang ada
  //   }
  // }

  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          showErrorDialog(context, state.e);
        }

        if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Scaffold(
            backgroundColor: const Color(0xFF0081C9),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0081C9),
                    ),
                    child: BlocProvider(
                      create: (context) => VehicleBloc()..add(VehicleGet()),
                      child: Align(
                        alignment: const AlignmentDirectional(-1.00, 0.00),
                        // child: RefreshIndicator(
                        //   onRefresh: () async {
                        //     await Future.delayed(Duration(seconds: 2));
                        //     // Kirim event untuk refresh mode saat ini
                        //     // setState(() {
                        //     //   motor!.modeAman;
                        //     // });
                        //     context.read<VehicleBloc>().state;
                        //   },
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BlocBuilder<VehicleBloc, VehicleState>(
                                      builder: (context, state) {
                                        if (state is VehicleSuccess) {
                                          if (state.data.isEmpty) {
                                            return Container();
                                          } else {
                                            return Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(18, 100, 18, 0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 7,
                                                        color: Color(0x2F1D2429),
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(70),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            18, 0, 18, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        const Icon(
                                                          Icons.motorcycle_sharp,
                                                          color:
                                                              Color(0xFF0081C9),
                                                          size: 24,
                                                        ),
                                                        Expanded(
                                                          child: Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.00, 0.00),
                                                            child: Container(
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        18,
                                                                        0,
                                                                        18,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    // Dropdown list jenis surat
                                                                    DropdownButtonHideUnderline(
                                                                      child:
                                                                          DropdownButton2(
                                                                        isExpanded:
                                                                            true,
                                                                        hint:
                                                                            Text(
                                                                          state
                                                                              .data
                                                                              .first
                                                                              .merk
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .labelMedium,
                                                                        ),
                                                                        items: state
                                                                            .data
                                                                            .map((vehicle) =>
                                                                                DropdownMenuItem<String>(
                                                                                  value: vehicle.merk,
                                                                                  child: Text(
                                                                                    vehicle.merk.toString(),
                                                                                    style: Theme.of(context).textTheme.labelMedium,
                                                                                  ),
                                                                                ))
                                                                            .toList(),
                                                                        value:
                                                                            merkMotor,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            merkMotor =
                                                                                value;
                                                                            context
                                                                                .read<VehicleBloc>()
                                                                                .add(VehicleGet());
                                                                          });
                                                                        },
                                                                        buttonStyleData:
                                                                            ButtonStyleData(
                                                                          height:
                                                                              40,
                                                                          width: double
                                                                              .infinity,
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left:
                                                                                  0,
                                                                              right:
                                                                                  0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(0),
                                                                            color:
                                                                                const Color(0xFFFfFfFf),
                                                                          ),
                                                                          elevation:
                                                                              0,
                                                                        ),
                                                                        menuItemStyleData:
                                                                            const MenuItemStyleData(
                                                                          height:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        return const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              18, 100, 18, 0),
                                          child: CircularProgressIndicator(),
                                          // child: Text(state.toString()),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 8),
                                          child: Container(
                                            decoration: const BoxDecoration(),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(10, 8, 10, 8),
                                              child: BlocBuilder<VehicleBloc,
                                                  VehicleState>(
                                                builder: (context, state) {
                                                  if (state is VehicleSuccess) {
                                                    if (state.data.isEmpty) {
                                                      return Container();
                                                    } else {
                                                      merkMotor = merkMotor ?? state.data.first.merk;
                                                      int index = state.data.indexWhere((vehicle) =>vehicle.merk == merkMotor);
                                                      motor = state.data.elementAt(index);
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0, 9, 0, 9),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                BlocBuilder<
                                                                    VehicleBloc,
                                                                    VehicleState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    if (state
                                                                        is VehicleSuccess) {
                                                                      return Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color:
                                                                                  const Color(0xFFFAFAFA),
                                                                              boxShadow: const [
                                                                                BoxShadow(
                                                                                  blurRadius: 7,
                                                                                  color: Color(0x2F1D2429),
                                                                                  offset: Offset(0, 3),
                                                                                )
                                                                              ],
                                                                              borderRadius:
                                                                                  BorderRadius.circular(70),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                  18,
                                                                                  8,
                                                                                  18,
                                                                                  8),
                                                                              child:
                                                                                  Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(80),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: motor!.image.toString(),
                                                                                      width: 80,
                                                                                      height: 80,
                                                                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                                                                            child: Text(
                                                                                              motor!.merk.toString(),
                                                                                              style: const TextStyle(
                                                                                                fontFamily: 'Nunito',
                                                                                                color: Color(0xFF111111),
                                                                                                fontSize: 14,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                                                                            child: Text(
                                                                                              motor!.plate.toString(),
                                                                                              style: const TextStyle(
                                                                                                fontFamily: 'Nunito',
                                                                                                color: Color(0xFF777777),
                                                                                                fontSize: 12,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await showModalBottomSheet(
                                                                                          isScrollControlled: true,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          enableDrag: false,
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return GestureDetector(
                                                                                              child: Padding(
                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                child: const PanduanWidget(),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ).then((value) => setState(() {}));
                                                                                      },
                                                                                      child: const Icon(
                                                                                        Icons.book,
                                                                                        color: Color(0xFF0081C9),
                                                                                        size: 24,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    return Container();
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0, 9, 0, 9),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: 100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFFCFCFC),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                5,
                                                                            color:
                                                                                Color(0x2F1D2429),
                                                                            offset: Offset(
                                                                                0,
                                                                                2),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                70),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Expanded(
                                                                              child:
                                                                                  ClipRRect(
                                                                                borderRadius: BorderRadius.circular(40),
                                                                                child: Image.asset(
                                                                                  'assets/images/mode_aman.png',
                                                                                  width: 150,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child:
                                                                                  Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(9, 9, 9, 9),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Mode Aman',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Poppins',
                                                                                        color: Color(0xFF111111),
                                                                                        fontSize: 18,
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        const Text(
                                                                                          'OFF',
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Poppins',
                                                                                            color: Color(0xFF111111),
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        ),
                                                                                        
                                                                                        // BlocBuilder<VehicleBloc, VehicleState>(
                                                                                        // builder: (context, state) {
                                                                                        //   if (state is VehicleSuccess) {
                                                                                            // Temukan motor yang sesuai dengan ID
                                                                                            // motor = state.vehicles.firstWhere((v) => v.id == motorId); // ganti motorId dengan ID yang sesuai
                                                                                            // isModeAman = motor!.modeAman == 1 ; // Ambil mode aman terbaru
      
                                                                                            // return 
                                                                                            Switch(
                                                                                              value: motor!.modeAman == 1 ? true : false,
                                                                                              // value: isModeAman,

                                                                                              // value: motor!.modeAman == 1,
                        
                                                                                              onChanged: (newvalue) {
                                                                                                setState(() {
                                                                                                  motor!.modeAman;
                                                                                                });
                                                                                                showConfirmDialog(context, motor!.id.toString(), 'Mode Aman', 'Apakah anda yakin ingin mengubah mode aman?');
                                                                                                // setState(() {
                                                                                                //   motor!.modeAman;
                                                                                                // });
                                                                                              },
                                                                                              activeColor: const Color(0xFF0081C9),
                                                                                              inactiveTrackColor: const Color(0xFF777777),
                                                                                            ),
                                                                                        //   }
                                                                                        //   return Container();
                                                                                        // }
                                                                                        //     ),
                                                                                          // }
                                                                                      
                                                    
                                                                                        const Text(
                                                                                          'ON',
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Poppins',
                                                                                            color: Color(0xFF111111),
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0, 9, 0, 9),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: 100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFFCFCFC),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                5,
                                                                            color:
                                                                                Color(0x2F1D2429),
                                                                            offset: Offset(
                                                                                0,
                                                                                2),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                70),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Expanded(
                                                                              child:
                                                                                  ClipRRect(
                                                                                borderRadius: BorderRadius.circular(40),
                                                                                child: Image.asset(
                                                                                  'assets/images/mode_mesin.png',
                                                                                  width: 150,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child:
                                                                                  Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(9, 9, 9, 9),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Mode Mesin',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Poppins',
                                                                                        color: Color(0xFF111111),
                                                                                        fontSize: 18,
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        const Text(
                                                                                          'OFF',
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Poppins',
                                                                                            color: Color(0xFF111111),
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        ),
                                                                                        Switch(
                                                                                          value: motor!.modeMesin == 1 ? true : false,
                                                                                          onChanged: (newvalue) {
                                                                                            showConfirmDialog(context, motor!.id.toString(), 'Mode Mesin', 'Apakah anda yakin ingin mengubah mode mesin?');
                                                                                          },
                                                                                          activeColor: const Color(0xFF0081C9),
                                                                                          inactiveTrackColor: const Color(0xFF777777),
                                                                                        ),
                                                                                        const Text(
                                                                                          'ON',
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Poppins',
                                                                                            color: Color(0xFF111111),
                                                                                            fontSize: 12,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0, 8, 0, 9),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap: () {
                                                                        showModalBottomSheet(
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          enableDrag:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Padding(
                                                                              padding:
                                                                                  MediaQuery.viewInsetsOf(context),
                                                                              child:
                                                                                  LacakMotorWidget(id: motor!.id.toString()),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            200,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: const Color(
                                                                              0xFFFCFCFC),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              blurRadius:
                                                                                  5,
                                                                              color:
                                                                                  Color(0x2F1D2429),
                                                                              offset:
                                                                                  Offset(0, 2),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              9,
                                                                              9,
                                                                              9,
                                                                              9),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                  child: Image.asset(
                                                                                    'assets/images/lacak_motor.png',
                                                                                    width: 150,
                                                                                    height: 100,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const Text(
                                                                                'Lacak Motor',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Poppins',
                                                                                  color: Color(0xFF111111),
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap: () {
                                                                        showModalBottomSheet(
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          enableDrag:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Padding(
                                                                              padding:
                                                                                  MediaQuery.viewInsetsOf(context),
                                                                              child:
                                                                                  RiwayatDeteksiWidget(id: motor!.id.toString()),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            200,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: const Color(
                                                                              0xFFFCFCFC),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              blurRadius:
                                                                                  5,
                                                                              color:
                                                                                  Color(0x2F1D2429),
                                                                              offset:
                                                                                  Offset(0, 2),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              9,
                                                                              9,
                                                                              9,
                                                                              9),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                  child: Image.asset(
                                                                                    'assets/images/riwayat_deteksi.png',
                                                                                    width: 150,
                                                                                    height: 100,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const Text(
                                                                                'Riwayat Deteksi',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Poppins',
                                                                                  color: Color(0xFF111111),
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  }
                                                  return Container();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      8, 8, 8, 8),
                                              child: Text(
                                                'SMODE',
                                                style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      8, 8, 8, 8),
                                              child: Text(
                                                'SMODE adalah singkatan dari Smart Motorcycle Detector. SMODE merupakan sebuah alat sistem keamanan motor yang sudah terintegrasi dengan internet, sehingga keamanan motor pengguna dapat di monitoring dari handphone.',
                                                style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  color: Color(0xFFFFFFFF),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 18, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.asset(
                                          'assets/images/aset.jpg',
                                          width: 150,
                                          height: 400,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 18, 0, 18),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(18, 0, 18, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Text(
                                                  'TIM',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: Color(0xFFFFFFFF),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(8, 8, 8, 8),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFCFCFC),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 7,
                                                        color: Color(0x2F1D2429),
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(40),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    child: Image.asset(
                                                      'assets/images/tim.png',
                                                      width: 300,
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Text(
                                                  'SMODE sendiri merupakan hasil karya dari mahasiswa Universitas Mulawarman yang juga merupakan TIM PKM KC tahun 2023.',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    color: Color(0xFFFFFFFF),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                18, 0, 18, 0),
                            child: Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC93C),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 7,
                                    color: Color(0x2F1D2429),
                                    offset: Offset(0, 3),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'SMODE',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(AuthLogout());
                                      },
                                      child: const Icon(
                                        Icons.settings_power,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

showConfirmDialog(
    BuildContext context, String id, String title, String message) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      if (title == "Mode Aman") {
        Navigator.pop(context);
        context.read<VehicleBloc>().add(VehicleModeAman(id));
      } else if (title == "Mode Mesin") {
        Navigator.pop(context);
        context.read<VehicleBloc>().add(VehicleModeMesin(id));
      }
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
      cancelButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
