# frozen_string_literal: true

require 'io/console'

# Prompts user for machine roles to decide what system packages
# get installed. See @roles and @roles_file to configure
# behavior.
module BrewRoles
  # Configuration
  @roles_file = File.join(Dir.home, '.Brewfile.roles')
  @roles = [
    {
      name: 'music',
      description: 'Music production tooling',
      selected: false
    },
    {
      name: 'games',
      description: 'Video game tooling',
      selected: false
    },
    {
      name: 'latex',
      description: 'Install MacTex',
      selected: false,
    }
  ]

  # Private
  @user_is_selecting = true
  @selected_index = 0

  def self.read_char
    begin
      $stdin.echo = false
      $stdin.raw!
      input = $stdin.getc.chr
      if input == "\e"
        input << $stdin.read_nonblock(3)
        input << $stdin.read_nonblock(2)
      end
    rescue StandardError
      nil
    ensure
      $stdin.echo = true
      $stdin.cooked!
    end

    input
  end

  def self.accept_user_input
    case read_char
    when ' '
      @roles[@selected_index][:selected] = !@roles[@selected_index][:selected]
    when "\r" # return/enter
      @user_is_selecting = false
    when "\e[B", 'j' # down arrow
      @selected_index = (@selected_index + 1) % @roles.size
    when "\e[A", 'k' # up arrow
      @selected_index = (@selected_index - 1) % @roles.size
    when "\u0003", "\e" # ctrl-c, escape
      exit 0
    end
  end

  def self.prompt_dialog
    puts "\e[34m?\e[0m \e[1mWhat roles does this machine have?\e[0m"
    puts "  \e[92m✔\e[0m core - Universal applications and tools\e[0m"

    @roles.each_with_index do |role, index|
      underline = "\e[#{index == @selected_index ? 4 : 0}m"
      selection_icon = role[:selected] ? "\e[92m✔\e[0m " : '  '
      puts "  #{selection_icon}#{underline}#{role[:name]} - #{role[:description]}\e[0m"
    end

    accept_user_input

    if @user_is_selecting # clear current output
      print "\e[#{@roles.size + 2}A\e[0J"
    else
      puts "\nYou can change roles later by editing #{@roles_file}"
    end
  end

  def self.prompt_for_roles
    if File.exist?(@roles_file)
      file_roles = File.read(@roles_file).split
      puts "Using roles: #{file_roles}"
      file_roles
    else
      BrewRoles.prompt_dialog while @user_is_selecting
      prompted_roles = @roles.filter { |role| role[:selected] }.map { |role| role[:name] }
      File.write(@roles_file, prompted_roles.join("\n"))
      puts "Using roles: #{prompted_roles}"
      prompted_roles
    end
  end
end
