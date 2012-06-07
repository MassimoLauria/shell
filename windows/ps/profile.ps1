
# Add my script dir to path
$scriptdir = $env:home + "\config\shell\windows\ps\";

$env:path           += ";" + $scriptdir;
$env:PSModulePath   += ";" + $scriptdir;


$MaximumHistoryCount = 150
