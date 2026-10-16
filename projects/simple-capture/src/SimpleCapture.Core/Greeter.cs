namespace SimpleCapture.Core;

public static class Greeter
{
    public static string Greet(string name) =>
        $"안녕하세요, {(string.IsNullOrWhiteSpace(name) ? "세계" : name.Trim())}님!";
}
