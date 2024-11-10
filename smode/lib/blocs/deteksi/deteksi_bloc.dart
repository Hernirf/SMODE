import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:smode/models/deteksi_model.dart';
import 'package:smode/services/deteksi_service.dart';

part 'deteksi_event.dart';
part 'deteksi_state.dart';

class DeteksiBloc extends Bloc<DeteksiEvent, DeteksiState> {
  DeteksiBloc() : super(DeteksiInitial()) {
    on<DeteksiEvent>((event, emit) async {
      if (event is DeteksiGet) {
        try {
          emit(DeteksiLoading());
          final deteksis = await DeteksiService().getDeteksi(event.id);
          emit(DeteksiSuccess(deteksis));
        } catch (e) {
          emit(DeteksiFailed(e.toString()));
        }
      }
    });
  }
}
