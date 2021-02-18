describe("Hello World", function() {


      it("should match", function() {
        var helloWorld = "Hello World";
        expect(helloWorld).toMatch("Hello World");
      });
});


/*
-- Version 2 --
describe("Hello World", function()){


      beforeEach(function() {
        var helloWorld = "hello World";
      });

      it("should be equal"), function(){
        expect(helloWorld).toEqual("Hello World")
      };
};
*/
