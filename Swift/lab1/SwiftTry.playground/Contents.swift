//: Playground - noun: a place where people can play
import UIKit
var i: Int = 0
let pi: Double = 3.14159
let string1 = "i = "+String(i)+", pi = "+String(pi)
let string2 = "i = \(i),pi = \(pi)"
let string3 = String(format: "i = %d, pi = %f", i , pi)

func appendStringWithNumber(string: String, number: Int) -> String
{
    return string + String(number)
}

appendStringWithNumber(string: "No.", number: 1)

func printHello(name:String)
{
    print("hello,"+name+"!")
}
printHello(name: "Jack")

class ViewController: UIViewController
{
    var name: String = "Jack"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printName()
    }
    func printName()
    {
        print(self.name)
    }
}
