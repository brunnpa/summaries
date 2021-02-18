// TaskList object definition within constructor. Properties are 'Title' and an array of 'Tasks'.
var Tasklist = function(title) {
    this.title = title;
    this.tasks = [];
};

// Method to set title of a Tasklist
Tasklist.prototype.setTitle = function (title) {
    this.title = title;
};

// Method to return title of a Tasklist
Tasklist.prototype.getTitle = function () {
    return this.title;
};

// Method to add a task to a Tasklist
Tasklist.prototype.addTask = function (task) {
    this.tasks.push(task);
};

// Method to get a tasks of a tasklist
Tasklist.prototype.getTasks = function () {
    return this.tasks;
};

