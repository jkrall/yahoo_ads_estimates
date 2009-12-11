require 'uri'
require 'open-uri'
require 'json'

module Yahoo
  class AdsEstimates

    attr_reader :keyword
    attr_reader :budgets
    attr_reader :max_cpcs, :impressions, :clicks

    def initialize(_keyword, _budgets=[1.0, 50.0])
      @keyword = _keyword
      @budgets = _budgets

      @max_cpcs = []
      @impressions = []
      @clicks = []

      @budgets.each do |budget|
        begin
          json = query(budget)
          result = JSON.parse(json)
          @impressions << result['impressions'].to_f
          @clicks << result['clicks'].to_f
          @max_cpcs << result['maxBid'].to_f
        rescue
          if defined?(RAILS_DEFAULT_LOGGER)
            RAILS_DEFAULT_LOGGER.info "Problem querying and parsing Yahoo, json: #{json}"
          else
            puts "Problem querying and parsing Yahoo, json: #{json}"
          end
        end
      end
    end

    private

    def request_uri(_budget)
      # From: http://sem.smallbusiness.yahoo.com/searchenginemarketing/marketingcost.php
      _keyword_escaped = URI.escape(@keyword)
      "http://sem.smallbusiness.yahoo.com/inc/getKeywordForecast.php?format=json&budget=#{_budget}&keyword=#{_keyword_escaped}&target=none"
    end

    def query(_budget)
      open(request_uri(_budget)) { |f| f.string }
    end

  end
end
