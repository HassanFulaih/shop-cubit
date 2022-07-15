part of 'search_cubit.dart';

abstract class SearchStates {}

class SearchInitial extends SearchStates {}

class GetSearchLoadingStatus extends SearchStates {}

class GetSearchSuccessStatus extends SearchStates {}

class GetSearchErrorStatus extends SearchStates {
  final String error;

  GetSearchErrorStatus(this.error);
}
