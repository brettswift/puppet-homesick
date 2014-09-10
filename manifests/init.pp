# Public: Install homesick
#
# Examples
#
#   include homesick
class homesick (
	$git_uri = undef,
	$github_project_name = undef,
	){

	
	if (empty($git_uri) and empty($github_project_name)){
  		fail("Missing required params: one of 'git_uri' or 'github_project_name' must be supplied")
	}

	unless ( empty($git_uri) or empty($github_project_name)){
		fail("Too many params: only one of git_uri:'${git_uri}', or github_project_name: '${github_project_name}' can be suplied.")
	}

	if empty($github_project_name) {
	  	$project_name_dirty = regsubst($git_uri, '^(.*[\\\/])', '')
	  	$project_name       = regsubst($project_name_dirty, '.git', '')
	  	$dotfile_uri 		= $git_uri
	} else {
		$project_name 		= $github_project_name
		$dotfile_uri		= "git@github.com:${github_login}/${project_name}.git"
  	} 

	if(empty($dotfile_uri)) {fail("dotfile_uri was empty")}

	package { 'homesick':
    	ensure   => 'installed',
    	provider => 'gem',
	}

	exec { "homesick clone ${dotfile_uri}":
		creates 	=> "${::boxen_home}/.homesick/${project_name}"
	}

	#no need for idempotency check as homesick does that. 
	#maybe it's faster anyways? something shells out either way.
	exec { "homesick link ${project_name} --force": }

	# TODO: check for .homesickrc file and execute it 

	Package['homesick']->
	Exec["homesick clone ${dotfile_uri}"] -> 
	Exec["homesick link ${project_name} --force"]
}
