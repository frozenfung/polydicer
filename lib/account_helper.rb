require "Pry"

class Account
  attr_reader :pattern, :icon
  attr_accessor :username

  def initialize(current_records = [])
    record = current_records.find do |item|
      matches = item["url"].match(pattern) || {}
      not matches[:account].nil?
    end
    @username = record["value"] if record
  end

  def json
    return nil if @username.nil?
    {
      icon: icon,
      value: username,
      url: url
    }
  end

  def question
    "#{@type} [#{@username || ''}]:\n> "
  end

  def username=(new_value)
    if new_value == "nil"
      @username = nil
    elsif not new_value.empty?
      @username = new_value
    end
  end

  def url
    "#{@url}#{@username || ''}"
  end
end

class Twitter < Account
  def initialize(current_records = [])
    @type = "Twitter account"
    @pattern = %r{.+twitter\.com/(?<account>.+)(/)?}
    @icon = "fa-twitter"
    @url = "https://twitter.com/"
    super current_records
  end
end

class Facebook < Account
  def initialize(current_records = [])
    @type = "Facebook account"
    @icon = "fa-facebook-official"
    @pattern = %r{.+facebook\.com/(?<account>.+)(/)?}
    @url = "https://www.facebook.com/"
    super current_records
  end
end

class GitHub < Account
  def initialize(current_records = [])
    @type = "GitHub account"
    @pattern = %r{.+github\.com/(?<account>.+)(/)?}
    @icon = "fa-github"
    @url = "https://github.com/"
    super current_records
  end
end

class Dribbble < Account
  def initialize(current_records = [])
    @type = "Dribbble account"
    @icon = "fa-dribbble"
    @pattern = %r{.+dribbble\.com/(?<account>.+)(/)?}
    @url = "https://dribbble.com/"
    super current_records
  end
end

class Behance < Account
  def initialize(current_records = [])
    @type = "Behance account"
    @icon = "fa-behance"
    @pattern = %r{.+behance\.net/(?<account>.+)(/)?}
    @url = "https://www.behance.net/"
    super current_records
  end
end

class Linkedin < Account
  def initialize(current_records = [])
    @type = "Linkedin account"
    @pattern = %r{.+linkedin\.com/\w+/(?<account>.+)(/)?}
    @icon = "fa-linkedin-square"
    @url = "https://www.linkedin.com/in/"
    super current_records
  end
end

class Email < Account
  def initialize(current_records = [])
    @type = "Email address"
    @pattern = /(?<account>.+\@.+)/
    @icon = "fa-envelope-o"
    @url = ""
    super current_records
  end
end
