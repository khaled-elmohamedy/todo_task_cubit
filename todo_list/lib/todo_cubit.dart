import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super(const []);

  void addTask(String title) {
    if (title.trim().isEmpty) return;
    final newTodo = Todo(title.trim());
    emit([...state, newTodo]);
  }

  void toggleTask(int index) {
    final updated = List<Todo>.from(state);
    if (index >= 0 && index < updated.length) {
      updated[index] = Todo(updated[index].title, done: !updated[index].done);
      emit(updated);
    }
  }

  void removeTask(int index) {
    final updated = List<Todo>.from(state)..removeAt(index);
    emit(updated);
  }
}
