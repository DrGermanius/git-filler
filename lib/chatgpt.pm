package chatgpt;

use strict;
use warnings;
use LWP::UserAgent;
use JSON::MaybeXS;

my $url = 'https://api.openai.com/v1/chat/completions';

sub send_request {
    my ($prompt) = @_;

    my $payload = {
        "model" => "gpt-3.5-turbo-16k",
        "messages" => [{"role" => "user", "content" => $prompt}],
        "temperature" => 0.9,
        "max_tokens" => 2048,
    };

    my $json_payload = encode_json($payload);

    my $ua = LWP::UserAgent->new;
    my $headers = HTTP::Headers->new(
        'Content-Type' => 'application/json',
        'Authorization' => 'Bearer token',
    );
    $ua->default_headers($headers);
    my $response = $ua->post($url, Content => $json_payload);
    if (!$response->is_success) {
        die "Request failed: " . $response->status_line;
    }
    
    my $content = decode_json($response->content)->{choices}[0]->{message}->{content};
        return $content;
}

1;