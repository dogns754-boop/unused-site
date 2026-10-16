"""__NAME__ 진입점."""

import argparse


def greet(name: str) -> str:
    return f"안녕하세요, {name}님!"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="__NAME__", description="__DESC__")
    parser.add_argument("name", nargs="?", default="세계", help="인사할 대상")
    args = parser.parse_args(argv)
    print(greet(args.name))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
