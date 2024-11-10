import 'package:flutter/material.dart';

class PanduanWidget extends StatefulWidget {
  const PanduanWidget({Key? key}) : super(key: key);

  @override
  State<PanduanWidget> createState() => _PanduanWidgetState();
}

class _PanduanWidgetState extends State<PanduanWidget> {
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 32),
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 8, 8, 8),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {},
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
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18, 10, 18, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Mode Aman',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: Color(0xFF0081C9),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Fitur ini berfungsi mengaktifkan mode aman pada alat, sehingga ketika motor digerakan oleh orang asing maka anda akan menerima notifikasi dari handphone anda.',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            Color(0xFF111111),
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
                              ),
                              Align(
                                alignment:
                                    const AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 8, 8, 8),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {},
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
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18, 10, 18, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Mode Mesin',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: Color(0xFF0081C9),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Fitur ini berfungsi untuk mematikan motor dengan mengubah arus listrik jika dinonaktifkan, Dan akan menyalakan kembali motor jika diaktifkan.',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            Color(0xFF111111),
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
                              ),
                              Align(
                                alignment:
                                    const AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 8, 8, 8),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {},
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
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18, 10, 18, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Lacak Motor',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: Color(0xFF0081C9),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Fitur ini berfungsi untuk melacak titik lokasi motor',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            Color(0xFF111111),
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
                              ),
                              Align(
                                alignment:
                                    const AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 8, 8, 8),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {},
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
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18, 10, 18, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Riwayat Deteksi',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      color: Color(0xFF0081C9),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Fitur ini menampilkan daftar deteksi yang terjadi pada motor anda.',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            Color(0xFF111111),
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
                              ),
                            ],
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
