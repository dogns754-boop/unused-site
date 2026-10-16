using SimplePdf.Core;

namespace SimplePdf.Core.Tests;

public class GreeterTests
{
    [Fact]
    public void Greet_WithName()
    {
        Assert.Equal("안녕하세요, 철수님!", Greeter.Greet("철수"));
    }

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    public void Greet_BlankName_UsesDefault(string name)
    {
        Assert.Equal("안녕하세요, 세계님!", Greeter.Greet(name));
    }
}
