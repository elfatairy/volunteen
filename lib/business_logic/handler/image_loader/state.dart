part of 'handler.dart';

sealed class ImageLoaderState extends Equatable {
  const ImageLoaderState();

  @override
  List<Object> get props => [];
}

final class ImageLoaderStateInitial extends ImageLoaderState {}

final class ImageLoaderStateLoading extends ImageLoaderState {}

final class ImageLoaderStateSuccess extends ImageLoaderState {}

final class ImageLoaderStateFailure extends ImageLoaderState {
  final String error;

  const ImageLoaderStateFailure({required this.error});
}
