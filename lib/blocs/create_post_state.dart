import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CreatePostState extends Equatable {
  final bool isloading;
  final TextEditingController control1;
  final TextEditingController control2;
  CreatePostState(
      {required this.isloading,
      required this.control1,
      required this.control2});

  @override
  // TODO: implement props
  List<Object?> get props => [this.isloading, this.control1, this.control2];
}
