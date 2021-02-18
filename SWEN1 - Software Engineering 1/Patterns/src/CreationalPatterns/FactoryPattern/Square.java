package CreationalPatterns.FactoryPattern;

public class Square implements Shape {
    @Override
    public void draw(){
        System.out.println("Draw a square and call draw()method");
    }
}
