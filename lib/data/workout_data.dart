import 'package:fitness_app/data/hive_database.dart';
import 'package:fitness_app/datetime/date_time.dart';
import 'package:flutter/cupertino.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
    final db = HiveDatabase();

    List<Workout> workoutList = [
        Workout(
            name: "Upper Body",
            exercises: [
                Exercise(
                    name: "Bicep Curls",
                    weight: "10kg",
                    reps: "10",
                    sets: "3",
                ),
            ],
        ),
        Workout(
            name: "Lower Body",
            exercises: [
                Exercise(
                    name: "Leg extension",
                    weight: "80kg",
                    reps: "10",
                    sets: "2",
                ),
            ],
        ),
    ];

    void initalizeWorkout() {
        if (db.previousDataExists()) {
            workoutList = db.readFromDatabase();
        } else {
            db.saveToDatabase(workoutList);
        }
        loadHeatMap();
    }

    List<Workout> getWorkoutList() {
        return workoutList;
    }

    int numberOfExercisesInWorkout(String workoutName) {
        Workout relevantWorkout = getRelevantWorkout(workoutName);
        return relevantWorkout.exercises.length;
    }

    void addWorkout(String name) {
        workoutList.add(Workout(name: name, exercises: []));
        notifyListeners();
        db.saveToDatabase(workoutList);
    }

    void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets) {
        Workout relevantWorkout = getRelevantWorkout(workoutName);

        relevantWorkout.exercises.add(
            Exercise(
                name: exerciseName,
                weight: weight,
                reps: reps,
                sets: sets,
            ),
        );
        notifyListeners();
        db.saveToDatabase(workoutList);
    }

    void checkOffExercise(String workoutName, String exerciseName) {
        Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

        relevantExercise.isCompleted = !relevantExercise.isCompleted;
        notifyListeners();
        db.saveToDatabase(workoutList);
        loadHeatMap();
    }

// get length of a given workout

// return relevant workout object, given a workout name
    Workout getRelevantWorkout(String workoutName) {
        Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
        return relevantWorkout;
    }
    // return relevant exercise object, given a workout name + exercise name
    Exercise getRelevantExercise(String workoutName, String exerciseName) {
        // find relevant workout first
        Workout relevantWorkout = getRelevantWorkout(workoutName);

        // then find the relevant exercise in that workout
        Exercise relevantExercise = relevantWorkout.exercises
            .firstWhere((exercise) => exercise.name == exerciseName);

        return relevantExercise;
    }


    String getStartDate() {
        return db.getStartDate();
    }

    Map<DateTime, int> heatMapDataset = {};

    void loadHeatMap() {
        DateTime startDate = createDateTimeObject(getStartDate());
        int daysInBetween = DateTime.now().difference(startDate).inDays;

        for (int i = 0; i < daysInBetween + 1; i++) {
            String yyyymmdd = convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));
            int completionStatus = db.getCompletionStatus(yyyymmdd);
            int year = startDate.add(Duration(days: i)).year;
            int month = startDate.add(Duration(days: i)).month;
            int day = startDate.add(Duration(days: i)).day;
            final percentForEachDay = <DateTime, int>{
                DateTime(year, month, day): completionStatus,
            };
            heatMapDataset.addEntries(percentForEachDay.entries);
        }
    }
}
