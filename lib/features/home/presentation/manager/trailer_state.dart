abstract class TrailerState {}

class TrailerInitial extends TrailerState {}

class TrailerLoading extends TrailerState {}

class TrailerSuccess extends TrailerState {
  final String trailerKey;
  TrailerSuccess(this.trailerKey);
}

class TrailerFailure extends TrailerState {
  final String errMessage;
  TrailerFailure(this.errMessage);
}
