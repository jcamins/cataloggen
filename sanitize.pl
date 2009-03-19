#!/usr/bin/perl

while (<>) {
	$_ =~ s/&/\\&amp;/g;
	$_ =~ s/%26/\\&amp;/g;
	$_ =~ s/%3C/&lt;/g;
	$_ =~ s/%3E/&gt;/g;

#	$_ =~ s/\xC3//g;
	$_ =~ s/\xC2\xA3/\\'{E}/g;
	$_ =~ s/\xC2\xB0/\\`{A}/g;
	$_ =~ s/\xC2\xB9/{\$\\ell\$}/g;
	$_ =~ s/\xC2\xBE/{\$\\ell\$}/g;
	$_ =~ s/\xC3\x89/\\'{E}/g;
	$_ =~ s/\xC3\xA1/\\'{a}/g;
	$_ =~ s/\xC3\xA7/\\c{c}/g;
	$_ =~ s/\xC3\xA8/\\`{e}/g;
	$_ =~ s/\xC3\xA9/\\'{e}/g;
	$_ =~ s/\xC3\xAB/\\"{e}/g;
	$_ =~ s/\xC3\xAD/\\'{\\i}/g;
	$_ =~ s/\xC3\xAF/\\"{\\i}/g;
	$_ =~ s/\xC3\xB1/\\~{n}/g;
	$_ =~ s/\xC3\xB3/\\'{o}/g;
	$_ =~ s/\xC3\xB5/\\~{o}/g;
	$_ =~ s/\xC3\xB6/\\"{o}/g;
	$_ =~ s/\xC3\xB8/{\\o}/g;
	$_ =~ s/\xC3\xBC/\\"{u}/g;
	$_ =~ s/\xC3\xA6/{\\ae}/g;
	$_ =~ s/\xC4\x90/{\\DJ}/g;
	$_ =~ s/\xC5\x93/{\\ae}/g;
	$_ =~ s/\xCA\xBB/{\\textceltpal}/g;
	$_ =~ s/\xCA\xBC/'/g;

	$_ =~ s/\xE2\x84\x93/{\$\\ell\$}/g;

#Corrections for composition errors
	$_ =~ s/l\xCC\x80/\\'{a}l/g;
	$_ =~ s/\xCC\x80/\\'{a}/g;
	$_ =~ s/(.)\xCC\x84/\\={\1}/g;
	$_ =~ s/a\xCC\x86/{\\ae}a/g;
	$_ =~ s/o\xCC\x88/\\"{o}/g;
	$_ =~ s/a\xCC\x8A/{\\aa}/g;
	$_ =~ s/b\xCC\xA0/\\'{u}b/g;
	$_ =~ s/n\xCC\xA4/\\'{o}n/g;
	$_ =~ s/b\xCD\xA0/\\'{u}b/g;

#Corrections for plain old errors!
	$_ =~ s/\[from old catalog\]//g;
	print $_;
}
