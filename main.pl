use strict;
use warnings;
use JSON;
use MIME::Base64;

use lib 'lib';
use chatgpt 'lib/chatgpt';

use FindBin qw($Bin);

my $repo_dir = "$Bin/test";

my $prompt = "Come up with pet project written in Go. The project must be single file, the project should be large size more than 5000 symbols. 
Write the answer to this in following format in json
{
Name: name of project
Code: code in golang
Readme: nice readme with more than 500 symbols of description. 
}

Do not include anything about count of symbols in readme;

please provide a valid json file
double check the json after generation";

my $response = decode_json chatgpt::send_request($prompt);

mkdir($repo_dir, 0700) unless(-d $repo_dir );
chdir($repo_dir) or die "can't chdir $repo_dir\n";

# GO Code
system('touch', 'main.go');
open(FH, '>', 'main.go') or die $!;
print FH (($response)->{Code});
close(FH);

# README
system('touch', 'README.md') == 0 or die "Failed to initialize Git repository: $!";
open(FH, '>', 'README.md') or die $!;
print FH (($response)->{Readme});
close(FH);

# Go mod
system('go', 'mod', 'init', ($response)->{Name})

