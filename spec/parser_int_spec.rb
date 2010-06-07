require "spec"
require "parser"
require "screen"

describe "parser" do
  before (:each) do
    @screen = Screen.new
    @parser = Parser.new @screen
  end

  it "should rendor pico screen" do

    input = "\e[?1049h\e[1;24r\e[m\e(B\e[4l\e[?7h\e[?12l\e[?25h\e[?1h\e=\e[?1h\e=\e[?1h\e=\e[39;49m\e[39;49m\e[m\e(B\e[H\e[2J\e[0;7m\e(B"
    input << "  GNU nano 2.2.2                New Buffer                                      "
    input << "\e[23;1H^G\e[m\e(B Get Help  \e[0;7m\e(B^O\e[m\e(B WriteOut  \e[0;7m\e(B^R\e[m\e(B Read File \e[0;7m\e(B^Y\e[m\e(B Prev Page \e[0;7m\e(B^K\e[m\e(B Cut Text  \e[0;7m\e(B^C\e[m\e(B Cur Pos"
    input << "\r\000\e[24d\e[0;7m\e(B^X\e[m\e(B Exit \e[14G\e[0;7m\e(B^J\e[m\e(B Justify   \e[0;7m\e(B^W\e[m\e(B Where Is  \e[0;7m\e(B^V\e[m\e(B Next Page \e[0;7m\e(B^U\e[m\e(B UnCut Text\e[0;7m\e(B^T\e[m\e(B To Spell"
    input << "\r\000\e[3d"

    @parser.read_tokens input
    puts @screen.display

    expected_output = "  GNU nano 2.2.2                New Buffer                                      \n"
    expected_output << (" " * 80 + "\n") * 21
    expected_output << "^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Page ^K Cut Text  ^C Cur Pos     \n"
    expected_output << "^X Exit      ^J Justify   ^W Where Is  ^V Next Page ^U UnCut Text^T To Spell    \n"
    @screen.to_s.should == expected_output
  end
end