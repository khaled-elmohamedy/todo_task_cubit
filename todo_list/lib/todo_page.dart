import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_cubit.dart';
import 'models/todo.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Todo Cubit')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter task',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TodoCubit>().addTask(controller.text);
                        controller.clear();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<TodoCubit, List<Todo>>(
                  builder: (context, todos) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Total tasks: ${todos.length}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                        ),
                        Expanded(
                          child: todos.isEmpty
                              ? const Center(child: Text('No tasks yet'))
                              : ListView.builder(
                                  itemCount: todos.length,
                                  itemBuilder: (context, index) {
                                    final todo = todos[index];
                                    return ListTile(
                                      title: Text(
                                        todo.title,
                                        style: TextStyle(
                                          decoration: todo.done
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                      leading: Checkbox(
                                        value: todo.done,
                                        onChanged: (_) => context
                                            .read<TodoCubit>()
                                            .toggleTask(index),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => context
                                            .read<TodoCubit>()
                                            .removeTask(index),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
