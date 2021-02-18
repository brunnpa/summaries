package CreationalPatterns.FactoryPattern;

public class Rectangle implements Shape{
    @Override
    public void draw(){
        System.out.println("Draw Rectangle and call draw() method");
    }

}
