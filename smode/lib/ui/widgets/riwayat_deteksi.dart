import 'package:flutter/material.dart';
// import 'package:flutter_application_2/blocs/deteksi/deteksi_bloc.dart';
// import 'package:flutter_application_2/shared/shared_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smode/blocs/deteksi/deteksi_bloc.dart';
import 'package:smode/shared/shared_methods.dart';
// import 'package:smode/blocs/deteksi/deteksi_bloc.dart';
// import 'package:smode/shared/shared_methods.dart';

class RiwayatDeteksiWidget extends StatefulWidget {
  final String id;
  const RiwayatDeteksiWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<RiwayatDeteksiWidget> createState() => _RiwayatDeteksiWidgetState();
}

class _RiwayatDeteksiWidgetState extends State<RiwayatDeteksiWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeteksiBloc()..add(DeteksiGet(widget.id)),
      child: BlocBuilder<DeteksiBloc, DeteksiState>(
        builder: (context, state) {
          if (state is DeteksiSuccess) {
            if (state.data.isEmpty) {
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
                                10, 0, 10, 0),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.00, 0.00),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFAFAFA),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color: Color(0x2F1D2429),
                                              offset: Offset(0, 3),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  18, 10, 18, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Kosong',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            Color(0xFF111111),
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
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
                      ),
                    ),
                  ),
                ),
              );
            } else {
          
              state.data.sort((a, b) => DateTime.parse(b.createdAt.toString()).compareTo(DateTime.parse(a.createdAt.toString())));
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
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 1,
                                  width: double.infinity,
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                    child: ListView(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: state.data.map((deteksi) {
                                        return Align(
                                          alignment: const AlignmentDirectional(
                                              0.00, 0.00),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8, 8, 8, 8),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFAFAFA),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 5,
                                                      color: Color(0x2F1D2429),
                                                      offset: Offset(0, 3),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          18, 10, 18, 10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0, 0, 0, 8),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              '${formattedDate(deteksi.createdAt.toString())} WITA',                                                       
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Color(
                                                                    0xFF0081C9),
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 8),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                'Motor anda terindikasi dalam keadaan ${deteksi.message.toString()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Color(
                                                                      0xFF111111),
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
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
                ),
              );
            }
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
