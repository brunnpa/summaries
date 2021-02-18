"use strict";

$(function() {
  TaskList.load('demo', function(taskList) {

    $('#taskList').html(taskList.render());

    $('#createTask').click(function(event) {
      event.preventDefault();
      var task = taskList.createTask('');
      $('#taskList ul').append(task.render());
    });

  });


});
