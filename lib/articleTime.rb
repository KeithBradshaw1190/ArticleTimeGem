require 'nokogiri'
require 'open-uri'
require 'uri'
require "net/http"

class ArticleTime
    def self.estimateTime(article)
        if (valid_url?(article))
            doc = Nokogiri::HTML(open(article))
           text= doc.css('div.story-body div.story-body__inner p').text
            estimate(text)
        elsif(article.instance_of?(String))
            estimate(article)
        else
            puts "Error"
        end
    end
    
    def self.valid_url?(url)
        uri = URI.parse(url)
        uri.is_a?(URI::HTTP) && !uri.host.nil?
        rescue URI::InvalidURIError
        false
    end

    def self.estimate(text)
        amnt_words=text.split(" ").size
       # puts "Amount of words #{amnt_words}"
        amnt_sentences = text.split(/[.?!]+/).grep(/\S/).count
      #  puts "Amount of sentences #{amnt_sentences}"

        #Average reading time is 200 Words Per Minute
        time_seconds=(amnt_words.to_f/200)*60
        time_seconds = time_seconds.round(2)
        time_mins = time_seconds.to_f/60
       # puts "Estimated seconds #{time_seconds}"
       # puts "Estimated minutes #{time_mins}"
        return [time_seconds.round(), time_mins.round()]
    end

end

