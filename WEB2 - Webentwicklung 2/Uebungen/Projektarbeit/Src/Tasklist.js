var tasklist = {
  title : "Default-Tasklisttitle",
  tasks : [],
  addTask : function(task) {
    this.tasks.push(task)
  }
}

var Tasklist = function() {
}



Tasklist.prototype = tasklist
