# -*- encoding : utf-8 -*-
module AssignmentsHelper
	def give_status(assignment_status_code)
		case(assignment_status_code)
		when 0
			return "Alloted"
		when 1
			return "In Progress"
		when 2
			return "Completed"
		end
	end	
end
