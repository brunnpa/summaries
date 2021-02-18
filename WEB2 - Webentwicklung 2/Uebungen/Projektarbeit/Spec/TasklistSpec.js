
describe("Tasklist", function(){
  it("should create a new tasklist" function () {
    newTasklist = new tasklist()
    expect(newTasklist).toEqual(Tasklist)
    })
})


describe("Task zu Taskliste", function(){
  it("should push a task into a tasklist", function() {
    tasklist = new tasklist()
    task = new task()
    tasklist.addTask(task)
    expect(task).toEqual(task)
  })
})
