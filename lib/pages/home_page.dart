






import 'package:fitness_app/data/workout_data.dart';
import 'package:fitness_app/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
//create new workout

class _HomePageState extends State<HomePage> {

  @override
  void initState()
  {
    super.initState();
    Provider.of<WorkoutData>(context,listen:false).initalizeWorkout();
  }
  //text controller
  final newWorkoutNameController=TextEditingController();

  void createNewWorkout()
  {
    showDialog(context:context,
      builder: (context)=>AlertDialog(
          title: Text('create new Workout'),
          content: TextField(
            controller: newWorkoutNameController,
          ),
        actions: [

          //save button
          MaterialButton(
              onPressed: save,
              child:Text('save'),
          ),


          //cancel button
          MaterialButton(
            onPressed: cancel,
            child:Text('cancel'),
          )
        ],
      ),);
  }

  //goToWorkoutPage
  void goToWorkoutPage(String workoutName)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkoutPage(workoutName: workoutName,),));
  }
  //save function
  void save(){
    String newWorkoutName=newWorkoutNameController.text;
    Provider.of<WorkoutData>(context,listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
    clear();
  }

  //cancel function
  void cancel(){
    Navigator.pop(context);
    clear();
  }

  //clear controller
  void clear()
  {
    newWorkoutNameController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(

    builder: (context,value,child)=> Scaffold(
      appBar: AppBar(
        title:Text('Workout tracker'),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewWorkout,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: value.getWorkoutList().length,
        itemBuilder: (context,index)=>ListTile(
          title: Text(value.getWorkoutList()[index].name),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: ()=>goToWorkoutPage(value.getWorkoutList()[index].name),
          ),

        ),
    ),
    ),
    );
  }
}
