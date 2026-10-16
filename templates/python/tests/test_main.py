import io
import unittest
from contextlib import redirect_stdout

from __PKG__.main import greet, main


class GreetTest(unittest.TestCase):
    def test_greet(self):
        self.assertEqual(greet("철수"), "안녕하세요, 철수님!")

    def test_main_prints_greeting(self):
        out = io.StringIO()
        with redirect_stdout(out):
            code = main(["영희"])
        self.assertEqual(code, 0)
        self.assertEqual(out.getvalue().strip(), "안녕하세요, 영희님!")


if __name__ == "__main__":
    unittest.main()
