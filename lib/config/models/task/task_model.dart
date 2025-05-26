import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String repeatType;
  final String days;
  final bool isCompleted;
  final String? time; // stored as "HH:mm"

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.repeatType,
    required this.days,
    this.isCompleted = false,
    this.time,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final rawDate = json['date'];
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date:
          rawDate is Timestamp
              ? rawDate.toDate()
              : DateTime.parse(rawDate.toString()), // ✅ Fix here
      repeatType: json['repeatType'] ?? '',
      days: json['days'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'repeatType': repeatType,
      'days': days,
      'isCompleted': isCompleted,
      'time': time,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? repeatType,
    String? days,
    bool? isCompleted,
    String? time,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      repeatType: repeatType ?? this.repeatType,
      days: days ?? this.days,
      isCompleted: isCompleted ?? this.isCompleted,
      time: time ?? this.time,
    );
  }
}
