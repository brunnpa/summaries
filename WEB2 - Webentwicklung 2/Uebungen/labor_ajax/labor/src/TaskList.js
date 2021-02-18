"use strict";

function TaskList(title) {
  this.id = null;
  this.tasks = [];
  this.title = title || "";
}

TaskList.prototype.size = function() {
  return this.tasks.length;
};

TaskList.prototype.createTask = function(title) {
  var _task = new Task(title);
  this.tasks.push(_task);
  return _task;
};


TaskList.prototype.render = function() {
  var $tasks = [];
  $.each(this.tasks, function(index, task) {
    $tasks.push(task.render());
  });

  return $('<ul>').append($tasks);
};

$("#submit").click(function(){
  alert('es hat funktioniert!');
});

/*
 * Loads the given tasklist from the server.
 *
 * @param {string} id - unique identifier of the tasklist to load
 * @param {function} callback - method to call after the tasklist
 *   was successfully loaded. receives fully populated tasklist
 *   object as first and only parameter.
 */
TaskList.load = function(id, callback) {
  $.getJSON('http://zhaw.herokuapp.com/task_lists/'+id, function(tasklist){

    var obj = JSON.parse(tasklist)
      obj.render()


  })
  var taskList = new TaskList();
  callback(taskList)
}
