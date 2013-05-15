require '../elevator'


describe Elevator do
	before { @elevator = Elevator.new(20) }
	subject { @elevator }
   
  it { should respond_to(:current_floor) } 
 	it { should respond_to(:floors) }
 	it { should respond_to(:max_floor) }
 	it { should respond_to(:min_floor) }
 	it { should respond_to(:door_closed) }

	describe "call" do
		before {@elevator.call(5) }
		its(:current_floor) { should == 5 }

		it "should not allow a call to floors above the max floor" do
			expect do
      	  @elevator.call(25)
    	end.to raise_error(RuntimeError)
  	end
	end

	describe "move!" do
		before {@elevator.move!(5) }
		its(:current_floor) { should == 5 }

		it "should move to floor 10" do
			@elevator.move!(10)
			@elevator.current_floor.should eql(10)
		end

		it "should not allow a move! to floors above the max floor" do
			expect do
    	  @elevator.call(25)
    	end.to raise_error(RuntimeError)
  	end
	end

	describe 'get_direction' do
		before { @elevator.current_floor = 5 }

		it "should point up" do
			@elevator.get_direction(10).should eql(1)
		end

		it "should point down" do
			@elevator.get_direction(1).should eql(-1)
		end
	end

	describe 'move_floor!' do
		before { @elevator.current_floor = 5 }

		it "should move up 1 floor" do
			@elevator.move_floor!(1)
			@elevator.current_floor.should eql(6)
		end

		it "should move down 1 floor" do
			@elevator.move_floor!(-1)
			@elevator.current_floor.should eql(4)
		end

		it "should not move down a floor on the bottom floor" do
			@elevator.current_floor = 1
			@elevator.move_floor!(-1)
			@elevator.current_floor.should eql (1)
		end

		it "should not move up a floor on the top floor" do
			@elevator.current_floor = 20
			@elevator.move_floor!(1)
			@elevator.current_floor.should eql (20)
		end										
	end

	describe 'close_door' do
		before { @elevator.close_door }
		its(:door_closed) { should == true}
	end

	describe 'open_door' do
		before { @elevator.open_door }
		its(:door_closed) { should == false}
	end

	describe 'is_number?' do
		it "should not be a integer" do
			@elevator.is_number?('string').should eql(false)
		end
		it "should not be a integer" do
			@elevator.is_number?(2.5).should eql(false)
		end
		it "should be a integer" do
			@elevator.is_number?(3).should eql(true)
		end
	end
end