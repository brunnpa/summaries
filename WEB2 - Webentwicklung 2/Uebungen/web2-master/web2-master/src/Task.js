// Task Object Constructor with properties "title" and "done"
var Task = function (title) {
    this.title = title,
    this.done = false;
};

// Method to set title of a task
Task.prototype.setTitle = function (title) {
    this.title = title;
};

// Method to get title of task
Task.prototype.getTitle = function () {
    return this.title;
};

// Method to set a task to 'Done'
Task.prototype.setDone = function () {
    this.done = true;
};

// Method to set a task to 'not done'
Task.prototype.unsetDone = function () {
    this.done = false;
};

// Method to get status of a task
Task.prototype.isDone = function () {
    return this.done;
};
