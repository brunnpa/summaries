describe("Task", function(){
    it("should create a new task and match title buy milk", function () {
        task = new Task("buy milk"),
        expect(newTasklist.title).toMatch("buy milk")
    })
})

