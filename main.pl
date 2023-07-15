use strict;
use warnings;
use JSON;
use MIME::Base64;

use lib 'lib';
use chatgpt 'lib/chatgpt';

use FindBin qw($Bin);

my $repo_dir = "$Bin/test";

my $prompt = "Write a large and non-trivial petproject using Golang for enchancing my github account for future.
Write the answer to this in following format in json:
{
Name: name of project
Code:  Go code with more than 5000 symbols
Readme: project's README with more than 500 symbols
}

please provide a valid json file";

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
my $modName = ($response)->{Name};
$modName =~ s/\s*//g;
system('go', 'mod', 'init', $modName);
