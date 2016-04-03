require 'Pry'

class Account
  attr_reader :pattern, :icon, :value

  def initialize(current_records = [])
    record = current_records.find do |item|
      matches = item['url'].match(pattern) || {}
      not matches[:account].nil?
    end
    @value = record["value"] if record
  end

  def question
    "#{@type} [#{@value || ''}]:\n> "
  end
end


class Twitter < Account
  def initialize(current_records = [])
    @type = "Twitter account"
    @pattern = /.+twitter\.com\/(?<account>.+)(\/)?/
    @icon = "fa-twitter"
    super current_records
  end
end


class GitHub < Account
  def initialize(current_records = [])
    @type = "GitHub account"
    @pattern = /.+github\.com\/(?<account>.+)(\/)?/
    @icon = "fa-github"
    super current_records
  end
end


class Linkedin < Account
  def initialize(current_records = [])
    @type = "Linkedin account"
    @pattern = /.+linkedin\.com\/in\/(?<account>.+)(\/)?/
    @icon = "fa-linkedin-square"
    super current_records
  end
end


class Email < Account
  def initialize(current_records = [])
    @type = "Email address"
    @pattern = /(?<account>.+\@.+)/
    @icon = "fa-envelope-o"
    super current_records
  end
end
