module Searchable
	extend ActiveSupport::Concern

	included do
		include Elasticsearch::Model
		mapping do 
		end
		def self.search
		end 
	end
end