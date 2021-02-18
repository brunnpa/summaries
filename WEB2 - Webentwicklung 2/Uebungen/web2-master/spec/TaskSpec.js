describe("Task", function () {

    beforeEach(function() {
        task = new Task("This is an awesome to do task");
    });

    it('should return the title of the task', function () {
        task.setTitle("Web2 Labor abgeben");
        expect(task.getTitle()).toEqual("Web2 Labor abgeben");
    });

    it('should be reported as not done', function () {
        expect(task.isDone()).toBeFalsy();
    });

    it('should be returned as done', function () {
        task.setDone();
        expect(task.isDone()).toBeTruthy();
    });

});