require 'spec_helper'

describe 'homesick' do

	let(:facts){{
				:github_login 	=> 'cmurphy',
				:boxen_user	 	=> 'charliemurphy'
	}}
	$full_git_uri = 'git@github.com:cmurphy/your_couch.git'

	shared_examples_for "basic usage" do 
		it do
			should contain_file("/Users/charliemurphy/.homesick")
			should contain_exec("homesick pull your_couch")
			should contain_exec("homesick rc your_couch")
			should contain_exec("homesick link your_couch --force")
			should contain_exec("homesick clone #{$full_git_uri}").with(
												  'cwd'     	=> "/Users/charliemurphy/.homesick",
												  'user'     	=> 'charliemurphy'
												)
			should contain_ruby_gem('homesick for all rubies')
		end
	end

	context " when passed full git uri" do
		let(:params){{
				 :git_uri => $full_git_uri
		}}
		it_behaves_like "basic usage"
	end

	context " when passed short git uri" do

		let(:params){{
				 :github_project_name => 'your_couch'
		}}
		it_behaves_like "basic usage"
	end

	context " no params" do
		it do
			expect {
				should contain_exec("homesick pull your_couch")
			}.to raise_error(Puppet::Error, /Missing/)
		end
	end

	context " too many params" do
		let(:params){{
				 :git_uri => $full_git_uri,
				 :github_project_name => 'your_couch'
		}}
		it do
			expect {
				should contain_exec("homesick pull your_couch")
			}.to raise_error(Puppet::Error, /Too many/)
		end
	end


end
