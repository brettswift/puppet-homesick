require 'spec_helper'

describe 'homesick' do

	context " when passed full git uri" do 
		$full_git_uri = 'git@github.com:cmurphy/your_couch.git'
		let(:params){{
			:git_uri => $full_git_uri,
			}}
	  	it do
	    	# should contain__ruby_gem('homesick for all rubies').with({
	     #  	:gem => 'homesick',
	    	# })
	    	should contain_exec("homesick link your_couch --force")
	    	# should contain_file('/Users/cmurphy/.homesick')
	    	should contain_exec("homesick clone #{$full_git_uri}")
	    end

  	end

  	context " when passed short git uri" do

		let(:params){{
			:github_project_name => 'your_couch',
			}}
		let(:facts){{
			:boxen_user => 'cmurphy'
			}}
	  	it do
	    	# should contain_file('homesick::castle').with({
	     #  		:provider => 'gem'
	    	# })
	    	should contain_exec("homesick link your_couch --force")
	    	# should contain_exec("homesick clone #{$full_git_uri}")

	    end
	end

end
