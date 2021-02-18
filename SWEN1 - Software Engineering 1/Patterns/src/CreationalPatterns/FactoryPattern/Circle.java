package CreationalPatterns.FactoryPattern;

public class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Draw circle and call draw() method.");
    }
}
