describe("TaskList", function () {

    beforeEach(function () {
        tasklist = new Tasklist("ZHAW To Do List");
    });

    it('should return the title', function () {
        expect(tasklist.getTitle()).toEqual("ZHAW To Do List");
    });

    it('should change the title', function () {
        tasklist.setTitle("Einkaufsliste");
        expect(tasklist.getTitle()).toEqual("Einkaufsliste");
    });

    it('should add a task to the taskliste', function () {
        var web2task = new Task("WEB 2 1. Milestone abgeben");
        tasklist.addTask(web2task);
        expect(tasklist.getTasks()).toContain(web2task);
    });
});