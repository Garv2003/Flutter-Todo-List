import 'package:flutter/material.dart';
import 'package:flutter_forms_files/models/todo.dart';
import 'package:flutter_forms_files/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Priority _selectedPriority = Priority.low;
  String _title = '';
  String _description = '';

  final List<Todo> todos = [
    const Todo(
        title: 'Buy milk',
        description: 'There is no milk left in the fridge!',
        priority: Priority.high),
    const Todo(
        title: 'Make the bed',
        description: 'Keep things tidy please..',
        priority: Priority.low),
    const Todo(
        title: 'Pay bills',
        description: 'The gas bill needs paying ASAP.',
        priority: Priority.urgent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ToDo Title',
                        hintText: 'Enter the ToDo title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ToDo Description',
                        hintText: 'Enter the ToDo description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<Priority>(
                      value: _selectedPriority,
                      items: Priority.values
                          .map((priority) => DropdownMenuItem(
                                value: priority,
                                child:
                                    Text(priority.toString().split('.').last),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final newTodo = Todo(
                            title: _title,
                            description: _description,
                            priority: _selectedPriority,
                          );
                          setState(() {
                            todos.add(newTodo);
                          });
                          _formKey.currentState!.reset();
                          _selectedPriority = Priority.low;
                          FocusScope.of(context).unfocus();
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Add Todo'),
                    ),
                  ],
                ))
            // TextField(
            //   controller: _emailController,
            //   keyboardType: TextInputType.emailAddress,
            //   decoration: const InputDecoration(
            //     labelText: 'Email',
            //     hintText: 'Enter your email',
            //   ),
            // ),
            // const SizedBox(height: 20),
            // FilledButton(
            //   onPressed: () {
            //     print(_emailController.text.trim());
            //   },
            //   child: const Text('Submit'),
            // ),
          ],
        ),
      ),
    );
  }
}
