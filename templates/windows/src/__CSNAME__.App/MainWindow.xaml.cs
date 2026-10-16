using System.Windows;
using __CSNAME__.Core;

namespace __CSNAME__.App;

// 화면 연결만 담당한다. 로직은 __CSNAME__.Core 에.
public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void GreetButton_Click(object sender, RoutedEventArgs e)
    {
        Output.Text = Greeter.Greet(NameBox.Text);
    }
}
