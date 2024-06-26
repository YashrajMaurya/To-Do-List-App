class todo {
  String? id;
  String? todoText;
  bool isDone;

  todo({required this.id, required this.todoText, this.isDone = false});
  static List<todo> todoList() {
    return [
      todo(id: '1', todoText: 'Morning Exercise', isDone: true),
      todo(id: '2', todoText: 'Buy Groceries', isDone: true),
      todo(
        id: '3',
        todoText: 'Check Emails',
      ),
      todo(
        id: '4',
        todoText: 'Team Meeting',
      ),
      todo(
        id: '5',
        todoText: 'Work on mobile apps for 2 hours',
      ),
      todo(
        id: '6',
        todoText: 'Dinner',
      ),
    ];
  }
}
