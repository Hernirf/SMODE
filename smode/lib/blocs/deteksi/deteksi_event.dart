part of 'deteksi_bloc.dart';

sealed class DeteksiEvent extends Equatable {
  const DeteksiEvent();

  @override
  List<Object> get props => [];
}

class DeteksiGet extends DeteksiEvent {
  final String id;
  const DeteksiGet(this.id);

  @override
  List<Object> get props => [id];
}
