
class homesick (
  $git_uri = undef,
  $github_project_name = undef,
  ){

  #TODO: could use ~/.homesick, but is it created yet? 
  $homesick_dir = "/Users/${::boxen_user}/.homesick"

  ### Validation
  if (empty($git_uri) and empty($github_project_name)){
      fail("Missing required params: one of 'git_uri' or 'github_project_name' must be supplied")
  }

  unless ( empty($git_uri) or empty($github_project_name)){
    fail("Too many params: only one of git_uri:'${git_uri}', or github_project_name: '${github_project_name}' can be suplied.")
  }


  ### derive variables
  if empty($github_project_name) {
      $project_name_dirty = regsubst($git_uri, '^(.*[\\\/])', '')
      $project_name       = regsubst($project_name_dirty, '.git', '')
      $dotfile_uri     = $git_uri
  } else {
    $project_name     = $github_project_name
    $dotfile_uri    = "git@github.com:${::github_login}/${project_name}.git"
    }
    #ensure parsing worked
  if(empty($dotfile_uri)) {fail('dotfile_uri was empty')}

  #on first run, create.  Use this folder for .ruby-version
  file { $homesick_dir:
    ensure => directory,
  }
  #doesn't seem to be required, but breaks testing
  #TODO: re-enable locking down to a ruby in the future. 
  # ruby::local { $homesick_dir:
  #   version => '2.1.0'
  # }
  ruby_gem { 'homesick for all rubies':
    gem          => 'homesick',
    ruby_version => '*',
  }

  Exec {
    cwd     => "/Users/${::boxen_user}/.homesick",
    user     => $::boxen_user,
    environment => [
            # "RBENV_ROOT=/opt/boxen/rbenv",
            # "RUBYLIB=''",
            # "BUNDLE_BIN_PATH=''",
            "RUBYOPT=''",  # if is:  'RUBYOPT=-rbundler/setup' then this errors looking for rake. 
            "HOME=/Users/${::boxen_user}" #not sure why it can't find the HOME variable.. 
            ],
  }

  exec { "homesick clone ${dotfile_uri}":
    creates   => "/Users/${::boxen_user}/.homesick/repos/${project_name}",
  }

  #no need for idempotency check as homesick does that. 
  #maybe it's faster anyways? something shells out either way.
  exec { "homesick link ${project_name} --force": }

  exec { "homesick rc ${project_name}":
    onlyif     => "test -f /Users/${::boxen_user}/.homesick/repos/${project_name}/.homesickrc"
  }

  exec {"homesick pull ${project_name}": }

  File[$homesick_dir]->
  # Ruby::Local[$homesick_dir]->
  Ruby_gem['homesick for all rubies']->
  Exec["homesick clone ${dotfile_uri}"]->
  Exec["homesick link ${project_name} --force"] ->
  Exec["homesick pull ${project_name}"]
}
