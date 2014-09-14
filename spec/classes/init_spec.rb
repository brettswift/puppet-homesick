require 'spec_helper'

describe 'homesick' do

	# context " when passed full git uri" do 
		let(:params){{
			:git_uri => 'git@github.com:cmurphy/your_couch.git',
			}}
	  	# it do
	   #  	should contain_package('homesick').with({
	   #    	:provider => 'gem'
	   #  	})
	   #  	should contain_exec("homesick symlink your_couch")
	   #  end

  	# end

  	context " when passed short git uri" do
		let(:params){{
			:git_uri => 'cmurphy/your_couch',
			}}
	  	it do
	    	# should contain_file('homesick::castle').with({
	     #  		:provider => 'gem'
	    	# })
	    	should contain_exec("homesick link your_couch")
	    end
	end

end
