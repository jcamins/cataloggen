#!/usr/bin/perl

while (<>) {
	$_ =~ s/&/\\&/g;
	$_ =~ s/%26/\\&/g;
#	$_ =~ s/\xC3//g;
	$_ =~ s/\xC2\xA3/{\\'E}/g;
	$_ =~ s/\xC3\x89/{\\'E}/g;
	$_ =~ s/\xC3\xA1/{\\'a}/g;
	$_ =~ s/\xC3\xA8/{\\`e}/g;
	$_ =~ s/\xC3\xA9/{\\'e}/g;
	$_ =~ s/\xC3\xAD/{\\'{\\i}}/g;
	$_ =~ s/\xC3\xB6/{\\"o}/g;
	$_ =~ s/\xC3\xBC/{\\"u}/g;
	$_ =~ s/\xC5\x93/{\\ae}/g;
	$_ =~ s/\xCA\xBB/'/g;

# Corrections for composition errors
	$_ =~ s/l\xCC\x80/{\\'a}l/g;
	$_ =~ s/(.)\xCC\x84/{\\=\1}/g;
	$_ =~ s/a\xCC\x86/{\\ae}a/g;
	$_ =~ s/a\xCC\x8A/{\\aa}/g;
	$_ =~ s/b\xCC\xA0/{\\'u}b/g;
	$_ =~ s/n\xCC\xA4/{\\'o}n/g;
	$_ =~ s/\xE2\x84\x93/{\\ell.}/g;
	$_ =~ s/\xBE/{\\ell.}/g;
	print $_;
}
