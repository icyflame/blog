use strict;
use warnings;

use POSIX qw(strftime);

if (@ARGV < 1) {
    die "You must provide the post title as an argument";
}

my $stub = $ARGV[0];
if ($stub !~ m/^[\w-]+$/i) {
    die "Provided blog post sub must match [a-z-]+";
}

my $file_name = "_posts/";
$file_name .= strftime "%Y-%m-%d-", localtime;
$file_name .= $stub;
$file_name .= ".md";

my $post_template = '---
layout: post
comments: true
title: 
categories:
---';

open (my $pipe, ">", $file_name);
print $pipe $post_template;
close($pipe);

print "Wrote template to file\n$file_name\n";
