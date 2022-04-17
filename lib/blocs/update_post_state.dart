import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:petterns_bloc/models/post_model.dart';

class Update_post_state extends Equatable {
  final bool isloading;
  final TextEditingController control1;
  final TextEditingController control2;
  final Post? post;

  Update_post_state(
      {required this.control1,
      required this.control2,
      this.post,
      required this.isloading});

  @override
  List<Object?> get props => [
        this.isloading,
        this.control1,
        this.control2,
        this.post,
      ];
}
