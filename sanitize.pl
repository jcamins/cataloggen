#!/usr/bin/perl

while (<>) {
	$_ =~ s/&/\\&amp;/g;
	$_ =~ s/%26/\\&amp;/g;
	$_ =~ s/%3C/&lt;/g;
	$_ =~ s/%3E/&gt;/g;

#Corrections for composition errors
	$_ =~ s/ie\xCC\x80r/i\\`{e}r/g;
	$_ =~ s/[a]?(.)\xCC\x80/\\'{a}\1/g;

#Corrections for misspellings
	$_ =~ s/d\xCC\x84et/{\\aa}det/g;
	$_ =~ s/g\xCC\x84el/{\\aa}gel/g;
	$_ =~ s/g\xCC\x84la/\\"{a}gla/g;
	$_ =~ s/l\xCC\x83t/\\"{a}lt/g;

	$_ =~ s/a\xCC\x86/{\\ae}a/g;
	$_ =~ s/o\xCC\x88/\\"{o}/g;
	$_ =~ s/u\xCC\x88/\\"{u}/g;
	$_ =~ s/ag\xCC\x89/\\h{a}g/g;
	$_ =~ s/a\xCC\x8A/{\\aa}/g;
	$_ =~ s/n\xCC\x8C/\\'{e}n/g;
	$_ =~ s/g\xCC\x93/\\c{g}/g;
	$_ =~ s/b\xCC\xA0/\\'{u}b/g;
	$_ =~ s/n\xCC\xA4/\\'{o}n/g;
	$_ =~ s/n\xCC\xA4/\\'{o}n/g;
	$_ =~ s/og\xCC\xA4/\\'{o}g/g;
	$_ =~ s/or\xCC\xA4/\\'{o}r/g;
	$_ =~ s/r\xCC\xA4/\\'{o}r/g;
	$_ =~ s/ool\xCC\xB2/o\\"{o}l/g;
	$_ =~ s/ol\xCC\xB2/o\\"{o}l/g;
	$_ =~ s/b\xCD\xA0/\\'{u}b/g;

#Fixing Russian
	$_ =~ s/\xCA\xB9/{\\textceltpal}/g;
	$_ =~ s/\xCA\xBB/{\\textceltpal}/g;
	$_ =~ s/i\xCC\x86/\\u{\\i}/g;
	$_ =~ s/(.)\xCD\xA1(.)\xEF\xB8\xA1/\\texttoptiebar{\1\2}/g;
	$_ =~ s/(.)\xCD\xA1(.)/\\texttoptiebar{\1\2}/g;

#UTF-8->LaTeX
	$_ =~ s/\xC2\xA3/\\'{E}/g;
	$_ =~ s/\xC2\xB0/\\`{A}/g;
	$_ =~ s/\xC2\xB9/{\$\\ell\$}/g;
	$_ =~ s/\xC2\xBE/{\$\\ell\$}/g;
	$_ =~ s/\xC3\x89/\\'{E}/g;
	$_ =~ s/[a]?\xC3\xA1/\\'{a}/g;
	$_ =~ s/\xC3\xA3/\\~{a}/g;
	$_ =~ s/\xC3\xA4/\\"{a}/g;
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
	$_ =~ s/\xC3\xBA/\\'{u}/g;
	$_ =~ s/\xC3\xBC/\\"{u}/g;
	$_ =~ s/\xC3\xA6/{\\ae}/g;
	$_ =~ s/\xC4\x90/{\\DJ}/g;
	$_ =~ s/\xC5\x93/{\\ae}/g;
	$_ =~ s/\xCA\xBC/'/g;

	$_ =~ s/(.)\xCC\x81/\\'{\1}/g;
	$_ =~ s/(.)\xCC\x83/\\~{\1}/g;
	$_ =~ s/(.)\xCC\x84/\\={\1}/g;
	$_ =~ s/(.)\xCC\x86/\\"{\1}/g;
	$_ =~ s/(.)\xCC\x93/'\1/g;
	$_ =~ s/(.)\xCC\xA3/\\d{\1}/g;
	$_ =~ s/(.)\xCC\xA6/\\c{\1}/g;
	$_ =~ s/(.)\xCC\xA7/\\c{\1}/g;
	$_ =~ s/(.)\xCC\xA8/\\c{\1}/g;

	$_ =~ s/(.)\xCC\x87/\\c{c}\1/g; #This substitution must be made before the following
	$_ =~ s/(.)\xCC\x82/\\~{a}\1/g;
	$_ =~ s/(.)\xCC\x88/\\`{e}\1/g;
	$_ =~ s/(.)\xCC\x8C/\\'{e}\1/g;
	$_ =~ s/(.)\xCC\xA4/\\'{\1}/g;
	$_ =~ s/(.)\xCC\xB2/\\"{o}\1/g;

	$_ =~ s/\xE2\x84\x93/{\$\\ell\$}/g;


#Dropping garbage!
	$_ =~ s/\xCC\x95//g;

#Corrections for plain old errors!
	$_ =~ s/\[from old catalog\]//g;
	print $_;
}
