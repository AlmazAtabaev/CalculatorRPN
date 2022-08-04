import Foundation

class StackNode {
    
    var element: String;
    var next: StackNode?
    init(_ element: String, _ next: StackNode?) {
        self.element = element
        self.next = next
    }
}

class MyStack {
    var top: StackNode? ;
    var size: Int;
    init() {
        self.top = nil
        self.size = 0
    }
    func push(_ element: String) {
        self.top = StackNode(element, self.top)
        self.size += 1
    }
    func isEmpty() -> Bool {
        if (self.size > 0 && self.top  != nil) {
            return false
        }
        else {
            return true
        }
    }
    
    func pop() {
        if (self.size > 0 && self.top  != nil) {
            let temp: StackNode? = self.top;
            self.top = temp!.next;
            self.size -= 1;
        }
    }
    
    func peek() -> String {
        if (self.top == nil) {
            return " "
        }
        return self.top!.element;
    }
}
class Conversion {
    func precedence(_ text: String) -> Int {
        switch text {
        case "+", "-":
            return 1
        case "*", "/":
            return 2
        case "^":
            return 3
        default:
            return -1
        }
    }
    func is_operator(_ text: String) -> Bool {
        if (text == "+" || text == "-" ||
                text == "*" || text == "/" ||
                text == "^") {
            return true
        }
        return false
    }
    func infixToPostfix(_ infixData: String) -> Array<String> {
        var result: String = ""
        var res: [String] = []
        var ss: String = ""
        let size: Int = infixData.count
        let s: MyStack? = MyStack()
        let infix = Array(infixData)
        var i: Int = 0
        while (i < size) {
            if ((infix[i] >= "0" && infix[i] <= "9") ||
                    (infix[i] >= "a" && infix[i] <= "z") ||
                    (infix[i] >= "A" && infix[i] <= "Z"))
            {
                result = result + String(infix[i]);
                if i+1 <= infix.count - 1 {
                    if ((infix[i+1] >= "0" && infix[i+1] <= "9") ||
                            (infix[i+1] >= "a" && infix[i+1] <= "z") ||
                            (infix[i+1] >= "A" && infix[i+1] <= "Z")) {
                        ss += String(infix[i])
                    } else {
                        if ss == "" {
                            res.append(String(infix[i]))
                        } else {
                            ss += String(infix[i])
                            
                            res.append(ss + String(infix[i]))
                        }
                        ss = ""
                    }
                } else {
                    if ss != "" {
                        res.append(ss + String(infix[i]))
                    } else {
                        res.append(String(infix[i]))
                    }
                }
            }
            else {
                if (s!.isEmpty() || infix[i] == "(") {
                    s!.push(String(infix[i]));
                }
                else if (infix[i] == ")") {
                    while (s!.isEmpty() == false &&
                            s!.peek()  != "(") {
                        result += s!.peek();
                        res.append(s!.peek())
                        s!.pop();
                    }
                    if (s!.peek() == "(") {
                        s!.pop();
                    }
                }
                else {
                    while (s!.isEmpty() == false &&
                            self.precedence(String(infix[i])) <=
                            self.precedence(String(s!.peek()))) {
                        result += s!.peek();
                        res.append(s!.peek())
                        s!.pop();
                    }
                    s!.push(String(infix[i]));
                }
            }
            i += 1;
        }
        while (s!.isEmpty() == false) {
            result += s!.peek();
            res.append(s!.peek());
            s!.pop();
        }
        return res
    }
}
