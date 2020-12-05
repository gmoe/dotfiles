require 'io/console'

# Configuration
$roles_file_name = "Brewfile.roles"
$roles = [
  {
    name: "music",
    description: "Music production tooling",
    selected: false,
  },
  {
    name: "games",
    selected: false,
    description: "Video game tooling",
  },
]

# Private
$user_is_selecting = true
$selected_index = 0

def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def prompt
  puts "\e[34m?\e[0m \e[1mWhat roles does this machine have?\e[0m"
  puts "  \e[92m✔\e[0m core - Universal applications and tools\e[0m"

  $roles.each_with_index do |role, index|
    bold = "\e[#{index == $selected_index ? 4 : 0}m"
    selection_icon = role[:selected] ? "\e[92m✔\e[0m " : "  "
    puts "  #{selection_icon}#{bold}#{role[:name]} - #{role[:description]}\e[0m"
  end

  print "\n"

  case read_char
  when " "
    $roles[$selected_index][:selected] = !$roles[$selected_index][:selected]
  when "\r"
    $user_is_selecting = false
  when "\e[B", "j" # down arrow
    $selected_index = $selected_index < 2 ? ($selected_index + 1) : $selected_index
  when "\e[A", "k" # up arrow
    $selected_index = $selected_index > 0 ? ($selected_index - 1) : $selected_index
  when "\u0003", "\e" # ctrl-c, escape
    exit 0
  end

  if $user_is_selecting then # clear current output
    print "\e[#{$roles.size + 3}A\e[0J"
  else
    puts "You can change roles later by editing ~/#{$roles_file_name}"
  end
end

def get_roles()
  if File.exists?($roles_file_name) then
    roles = File.read($roles_file_name).split
    puts "Using roles: #{roles}"
    return roles
  else
    prompt while($user_is_selecting)
    roles = $roles.filter { |role| role[:selected] }.map { |role| role[:name] }
    File.write($roles_file_name, roles.join("\n"))
    puts "Using roles: #{roles}"
    return roles
  end
end
