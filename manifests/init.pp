# Public: Install homesick
#
# Examples
#
#   include homesick
class homesick (
	$git_uri,
	){

	if $git_uri =~ /.git/ {
	  	$project_name_dirty = regsubst($git_uri, '^(.*[\\\/])', '')
	  	$project_name       = regsubst($project_name_dirty, '.git', '')
	} else {
		$project_name 		= regsubst($git_uri, '^(.*\/).+', '')	
  	}

	package { 'homesick':
    	ensure   => 'installed',
    	provider => 'gem',
	}

	exec { "homesick clone ${git_uri}":
		creates 	=> "~/.homesick/${project_name}"
	}

	#no need for idempotency check as homesick does that. 
	#maybe it's faster anyways? something shells out either way.
	exec { "homesick link ${project_name} --force": }

	# TODO: check for .homesickrc file and execute it 

}
