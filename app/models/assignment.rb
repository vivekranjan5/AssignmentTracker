# -*- encoding : utf-8 -*-
class Assignment < ActiveRecord::Base
	#extend Enumerize
	include ActiveModel::ForbiddenAttributesProtection

	#implementing elastic Search
	include Elasticsearch::Model
	#include Elasticsearch::Model::Callbacks

	#many to many association with the user
	after_create :index_document
	after_update :index_document
	after_destroy :delete_document
	
	def index_document
		IndexerWorker.delay.perform('index', self.id)
	end


	def delete_document
		IndexerWorker.delay.perform('delete', self.id)
	end

	attr_accessible :title,:content,:start_date, :subtasks_attributes


	has_many :assignments_users, :class_name => "AssignmentsUser", :dependent => :destroy
	has_many :assigned_users , :through => :assignments_users, :source => :user
	

	#has many belongs to association with comments
	has_many :comments, :dependent => :destroy



	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"


	validates :title, presence: true
	validates :content, presence: true

	has_many :subtasks
	accepts_nested_attributes_for :subtasks, allow_destroy: true

	mapping do
		indexes :id, index: :not_analyzed
		indexes :none 
		indexes :title
		indexes :content
	end

	def as_indexed_json(options={})
		self.as_json(only: [:id, :title, :content], include: {
			comments: { only: [:id, :body]},
			creator: {only: [:name, :email]},
			assigned_users: {only: [:name, :email]}
			})
	end


	class << self

		def custom_search(query)
			__elasticsearch__.search(query: multi_match_query(query))
		end

		def multi_match_query(query)
			{
				multi_match: {
					query: query,
					type: "best_fields", #most_fields, phrase, phrase_prefix, cross_fields
					fields: ["title", "content","comments.body", "creator.name", "creator.email", "assigned_users.name", "assigned_users.email"]
				}

			}
		end
	end
end
