require "./controller.rb"
require "./app.rb"
require "test/unit"

class Ims_Tester < Test::Unit::TestCase

  #@c = Controller.new



  def test_add_artist
    c = Controller.new
    c.find_command('erase')

    assert_equal("I will fill in help message later!",c.find_command('help'))
    # assert_equal("Added artist Smash Mouth under ID sm.",c.find_command("add artist Smash Mouth"))
    # assert_equal("Added artist Queen under ID qn.",c.find_command("add artist Queen"))
    # assert_equal("Added artist Niel Patrick Harris under ID nh.",c.find_command("add artist Niel Patrick Harris"))

  end

  # def test_add_track
  #
  # end
  #
  # def test_play_track
  #
  # end
  #
  # def test_info_artist
  #
  # end
  #
  # def test_info_track
  #
  # end
  #
  # def test_count
  #
  # end
  #
  # def test_list
  #
  # end
  #
  # def test_reload
  #
  # end
end
