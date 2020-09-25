import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class KeicyCookieState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed

  KeicyCookieState({
    @required this.progressState,
  });

  factory KeicyCookieState.init() {
    return KeicyCookieState(
      progressState: 0,
    );
  }

  KeicyCookieState copyWith({
    int progressState,
  }) {
    return KeicyCookieState(
      progressState: progressState ?? this.progressState,
    );
  }

  KeicyCookieState update({
    int progressState,
  }) {
    return copyWith(
      progressState: progressState,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
    };
  }

  @override
  List<Object> get props => [
        progressState,
      ];

  @override
  bool get stringify => true;
}
