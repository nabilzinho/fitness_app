import 'package:flutter/cupertino.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  /*WORKOUT DATA STRUCTURE
  - This overall list contains the different workouts
  - Each workout has a name, and list of exercises*/


List<Workout> workoutList = [
    // default workout
    Workout(
        name: "Upper Body",
        exercises: [
            Exercise(
                name: "Bicep Curls",
                weight: "10kg",
                reps: "10",
                sets: "3"
            ),
        ] ,
),
];

// get the list of workouts
    List<Workout> getWorkoutList() {
        return workoutList;
    }

    // get length of a given workout
    int numberOfExercisesInWorkout(String workoutName) {
        Workout relevantWorkout = getRelevantWorkout(workoutName);
        return relevantWorkout.exercises.length;
    }


// add a workout
    void addWorkout(String name) {
        // add a new workout with a blank list of exercises
        workoutList.add(Workout(name: name, exercises: []));
        notifyListeners();
    }
// add an exercise to a workout
    void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets)
    {
       Workout relevantWorkout=getRelevantWorkout(workoutName);
       // add an exercise to a workout
       relevantWorkout.exercises.add(
           Exercise(
               name: exerciseName,
               weight: weight,
               reps: reps,
               sets: sets,
           ),
       );
       notifyListeners();
    }
    // check off exercise
    void checkOffExercise(String workoutName, String exerciseName) {
        // find the relevant workout and relevant exercise in that workout
        Exercise relevantExercise=getRelevantExercise(workoutName, exerciseName);
        //check off boolean to show user exo is completed
        relevantExercise.isCompleted=!relevantExercise.isCompleted;
        notifyListeners();
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




}
