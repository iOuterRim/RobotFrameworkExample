class CalculatorLibrary:
    """A simple Robot Framework library implemented in Python."""

    def add_numbers(self, a, b):
        return int(a) + int(b)

    def divide_numbers(self, a, b):
        a, b = int(a), int(b)
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b

    def number_should_be_positive(self, number):
        if int(number) <= 0:
            raise AssertionError(f"{number} is not positive")