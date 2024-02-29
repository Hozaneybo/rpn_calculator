

class Calculator {
  List<double> stack = [];

  void push(double number) {
    stack.add(number);
    printStack();
  }

  void performOperation(String operation) {
    if (stack.length < 2) {
      print("Not enough elements in the stack.");
      return;
    }

    double num2 = stack.removeLast();
    double num1 = stack.removeLast();
    double result;

    switch (operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      default:
        print("Unsupported operation");
        return;
    }

    stack.add(result);
    printStack();
  }

  void printStack() {
    print(stack);
  }

  void clear() {
    stack.clear();
  }

}
