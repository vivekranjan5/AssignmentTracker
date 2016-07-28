class IndexerWorker
	include Sidekiq::Worker
	sidekiq_options queue: :elasticsearch
	
	def perform(operation,record_id)
		self.send(operation,record_id)
	end

	private

	def index(record_id)
		record = Assignment.find(record_id)
		record.__elasticsearch__.index_document
	end

	def delete(record_id)
		client = Assignment.__elasticsearch__.client
		client.delete index: Assignment.index_name, type: Assignment.model_name.to_s.downcase, id: record_id
	end
end