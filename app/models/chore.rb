class Chore < ActiveRecord::Base
	belongs_to :child
	belongs_to :task

	validates_date :due_on

	scope :by_task, -> { joins(:task).order('tasks.name') }
	scope :chronological, -> { order(:due_on) }
	scope :pending, -> { where(completed: false) }
	scope :done, -> { where(completed: true) }
	scope :past, -> { where('due_on < ?', Date.today) }
	scope :upcoming, -> { where('due_on >= ?', Date.today) }

	def status
		if completed?
			return 'Completed'
		else
			return 'Pending'
		end	
	end
end
