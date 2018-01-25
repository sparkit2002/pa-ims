require "./controller.rb"

command = ""
control = Controller.new
while command != "exit"
  print "ims> "
  command = $stdin.gets.chomp
  control.find_command(command)
end
