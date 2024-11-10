part of 'deteksi_bloc.dart';

sealed class DeteksiState extends Equatable {
  const DeteksiState();
  
  @override
  List<Object> get props => [];
}

final class DeteksiInitial extends DeteksiState {}

final class DeteksiLoading extends DeteksiState {}

final class DeteksiFailed extends DeteksiState {
  final String e;
  const DeteksiFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class DeteksiSuccess extends DeteksiState {
  final List<DeteksiModel> data;
  const DeteksiSuccess(this.data);

  @override
  List<Object> get props => [data];  
}
