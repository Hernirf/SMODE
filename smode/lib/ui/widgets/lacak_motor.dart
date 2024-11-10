import 'package:flutter/material.dart';
// import 'package:flutter_application_2/blocs/vehicle/vehicle_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smode/blocs/vehicle/vehicle_bloc.dart';
// import 'package:smode/blocs/vehicle/vehicle_bloc.dart';

class LacakMotorWidget extends StatefulWidget {
  final String id;
  const LacakMotorWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<LacakMotorWidget> createState() => _LacakMotorWidgetState();
}

class _LacakMotorWidgetState extends State<LacakMotorWidget> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VehicleBloc()..add(VehicleLocation(widget.id)),
      child: BlocBuilder<VehicleBloc, VehicleState>(
        builder: (context, state) {
          if (state is VehicleLocationSuccess) {
            CameraPosition initialCameraPosition = CameraPosition(
              target: LatLng(state.data.lat!, state.data.lon!),
              zoom: 15,
            );
            return Material(
              color: Colors.transparent,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.75,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAF0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 16, 0, 32),
                          child: Container(
                            width: 50,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDBE2E7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              18, 9, 18, 18),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAF0),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x2F1D2429),
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 16, 16, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Lokasi',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Color(0xFF111111),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.00, 0.00),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 8, 0, 8),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {},
                                        child: Container(
                                          width: double.infinity,
                                          height: 400,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFAFAF0),
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 5,
                                                color: Color(0x2F1D2429),
                                                offset: Offset(0, 3),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: GoogleMap(
                                            initialCameraPosition:
                                                initialCameraPosition,
                                            onMapCreated: (controller) {
                                              setState(() {
                                                mapController = controller;
                                              });
                                            },
                                            markers: {
                                              Marker(
                                                markerId:
                                                    const MarkerId('Vehicle'),
                                                position: LatLng(
                                                    state.data.lat!,
                                                    state.data.lon!),
                                                infoWindow: const InfoWindow(
                                                    title: 'Motor Saya'),
                                              ),
                                            },
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
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Material(
            color: Colors.transparent,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.75,
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAF0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 32),
                      child: Container(
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBE2E7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
