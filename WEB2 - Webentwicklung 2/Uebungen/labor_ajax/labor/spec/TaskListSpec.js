"use strict";

describe("TaskList", function () {
  var taskList;

  beforeEach(function () {
    taskList = new TaskList();
  });

  it("adds a new element", function () {
    taskList.createTask('test');
    expect(taskList.tasks[0].title).toEqual('test');
  });

  describe("render", function () {
    it("renders ul element", function () {
      expect(taskList.render()).toEqual('ul');
    });

    it("renders empty list when empty", function () {
      expect(taskList.render()).toBeEmpty();
    });
    it("renders tasks", function () {
      taskList.createTask('test task');
      expect(taskList.render().find('input[name=title]').val()).
          toBe('test task');

    });
  });

  describe("load", function () {

    var result;

    beforeEach(function () {
      // mock the ajax call to the server loading the tasklist
      spyOn($, "getJSON").and.callFake(function (url, callback) {
        callback({
          id: 'demo-list',
          title: 'the list',
          tasks: [
            {title: 'first task', done: true},
            {title: '2nd task', done: false},
          ]
        });
      });

      // execute a mocked ajax call and populate tasklist into result
      TaskList.load('testlist', function (taskList) {
        result = taskList;
      });
    });

    it('calls getJSON with the correct URL', function() {
      expect($.getJSON).toHaveBeenCalledWith("http://zhaw.herokuapp.com/task_lists/testlist", jasmine.any(Function));
    });

    it("stores the id of the tasklist", function() {
      expect(result.id).toEqual('demo-list');
    });
    it("stores the title of the tasklist", function() {
      expect(result.title).toEqual('the list');
    });

    it("creates a tasklist with 2 entries", function() {
      expect(result.tasks.length).toEqual(2);
    });

    it("populates the titles of the tasklist", function() {
      expect(result.tasks[0].title).toEqual('first task');
      expect(result.tasks[1].title).toEqual('2nd task');
    });

    it("populates the done status of the tasks", function () {
      expect(result.tasks[0].done).toBe(true);
      expect(result.tasks[1].done).toBe(false);
    });
  });

});
