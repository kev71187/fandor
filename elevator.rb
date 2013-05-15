class Elevator
	attr_accessor :floors, :current_floor, :max_floor, :min_floor, :door_closed
	UP = 1
	DOWN = -1

	def initialize(floors)
		unless is_number?(floors) && floors > 0
			return puts 'Enter a valid number that is greater than zero.' 
		end 
		
		@floors = (1 .. floors.to_i).to_a
		@current_floor = 0
		@max_floor = floors
		@min_floor = 1
		@door_closed = true
	end
	
	def call(floor)
		puts "You are on floor #{floor}"
		self.move!(floor)
	end

	def go_to(floor)
		puts "You are going to floor #{floor}"
		self.move!(floor)
	end

	def move!(floor)
		self.close_door
		direction = get_direction(floor)

		until self.current_floor == floor
			move = self.move_floor!(direction)

			if !move
				break
			end
		end

		self.open_door
	end

	def get_direction(floor)
		unless is_number?(floor) && self.min_floor <= floor && floor <= self.max_floor 
			raise 'Enter a valid floor.' 
		end

		return ((floor - self.current_floor) > 0) ? UP : DOWN
	end

	# 1 = up and -1 = down
	def move_floor!(direction)
		unless (direction === UP || direction === DOWN)
			raise "Enter a valid direction #{self.UP} for up and #{self.DOWN} for down."
			return false
		end

		if (self.current_floor == self.max_floor) && (direction > 0)
			puts "You are on the top floor."

			return false
		end

		if ((self.current_floor == self.min_floor) && (direction < 0))
			puts "You are on the bottom floor."
			return false
		end

		self.current_floor += direction
		puts "The elevator is on the #{self.current_floor} floor."

		return true
	end

	def close_door
		self.door_closed = true
		puts "Door closes."
	end

	def open_door
		self.door_closed = false
		puts "Door opens."
	end
	
	# helper functions
	def is_number?(value)
  	value.to_i === value
	end
end
