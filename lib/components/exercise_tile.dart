import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;

  const ExerciseTile({super.key, required this.exerciseName, required this.weight, required this.reps, required this.sets, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: ListTile(
        title: Text(
          exerciseName),
        subtitle: Row(
          children: [
            // weight
            Chip(
              label: Text(
                "${weight}kg",
              ), // Text
            ), // Chip

            // reps
            Chip(
              label: Text(
                "${reps} reps",
              ), // Text
            ), // Chip

            // sets
            Chip(
              label: Text(
                "${sets} sets",
              ), // Text
            ), // Chip
          ], // Row


        ),
      ),
    );
  }
}
