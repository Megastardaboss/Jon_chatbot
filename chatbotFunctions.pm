package chatbotFunctions;
use strict;
use warnings;
use Exporter;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw( isValidWord textFileToArray isProbableQuestion fixString isProbableImperative isProbableExclamatory );

# these are exported by default.
our @EXPORT = qw( isValidWord textFileToArray isProbableQuestion fixString isProbableImperative isProbableExclamatory );

sub isValidWord{

	my $word = $_[0];

	if($word eq "not" || $word eq "or" || $word eq "that" || $word eq "and" || $word eq "you" || $word eq "i" || $word eq "the" || $word eq "then" || $word eq "as" || $word eq "am" || $word eq "no"){
		return 0;
	}
	else{
		return 1;
	}

}

sub textFileToArray{

	my $filename = $_[0];
	my @outputarray;

	#open and read from used.txt
	open(my $fh, "<", $filename.".txt") or die "Can't open < ".$filename.".txt: $!";

	#for each line in the file
	while(my $line = <$fh>){

		chomp $line;
		
		#add this line to the array
		push @outputarray, $line;

	}

	close $fh;

	return @outputarray;
}

sub isProbableQuestion{

	my $str = $_[0];
	my $out = 0;

	#check for question marks
	if (index($str, "?") != -1) {
		$out = 1;
	}
	#check for question words at the beginning of the sentence
	if (index(lc($str), lc("What")) == 0 || index(lc($str), lc("Who")) == 0 || index(lc($str), lc("Whom")) == 0 || index(lc($str), lc("When")) == 0 || index(lc($str), lc("Where")) == 0 || index(lc($str), lc("Why")) == 0) {
		$out = 1;
	}
	#check for other indicators
	if (index(lc($str), lc("Is")) == 0 || index(lc($str), lc("Are")) == 0 || index(lc($str), lc("Aren't")) == 0 || index(lc($str), lc("Do")) == 0 || index(lc($str), lc("Will")) == 0 || index(lc($str), lc("Won't")) == 0 || index(lc($str), lc("Shall")) == 0 || index(lc($str), lc("Can")) == 0 || index(lc($str), lc("Must")) == 0) {
		$out = 1;
	}

	return $out;

}

sub isProbableImperative{

	my $str = $_[0];
	my $out = 0;

	#check for imperative words
	if (index(lc($str), lc("Must")) != -1 || index(lc($str), lc("Do")) == 0 || index(lc($str), lc("Go")) == 0 || index(lc($str), lc("Help")) == 0 || index(lc($str), lc("Learn")) == 0 || index(lc($str), lc("Listen")) == 0) {
		$out = 1;
	}
	#check for other indicators
	if (index(lc($str), lc("Obey")) == 0 || index(lc($str), lc("Pay Attention")) == 0 || index(lc($str), lc("have to")) != -1 || index(lc($str), lc("need to")) != -1 || index(lc($str), lc("shall")) != -1 || index(lc($str), lc("do not")) != -1) {
		$out = 1;
	}

	return $out;

}

sub isProbableExclamatory{

	my $str = $_[0];
	my $out = 0;

	#check for exclamation points
	if (index($str, "!") != -1) {
		$out = 1;
	}
	#check for one-word inputs
	if (index($str, " ") == -1) {
		$out = 1;
	}
	#check for imperative words
	if (index(lc($str), lc("Wow")) != -1 || index(lc($str), lc("Hello")) != -1 || index(lc($str), lc("Goodbye")) != -1 || index(lc($str), lc("Hi")) != -1 || index(lc($str), lc("Bye")) != -1 || index(lc($str), lc("ok")) != -1 || index(lc($str), lc("okay")) != -1 || index(lc($str), lc("k")) != -1 || index(lc($str), lc("yes")) != -1 || index(lc($str), lc("no")) != -1 || index(lc($str), lc("cool")) != -1) {
		$out = 1;
	}

	return $out;

}

sub fixString{

	my $str = $_[0];

	#all lowercase
	$str = lc($str);

	#add question mark to probable questions
	if(isProbableQuestion($str) == 1 && index($str, "?") == -1){
		$str .= "?";
	}

	#check for missing apostraphies
	$str = join( "what's", split("whats", $str) );
	$str = join( "how's", split("hows", $str) );
	$str = join( "where's", split("wheres", $str) );
	$str = join( "when's", split("whens", $str) );
	$str = join( "who's", split("whos", $str) );
	$str = join( "weren't", split("werent", $str) );
	$str = join( "wasn't", split("wasnt", $str) );
	$str = join( "would've", split("wouldve", $str) );
	$str = join( "should've", split("shouldve", $str) );
	$str = join( "could've", split("couldve", $str) );
	$str = join( "hadn't", split("hadnt", $str) );
	$str = join( "can't", split("cant", $str) );
	$str = join( "wouldn't", split("wouldnt", $str) );
	$str = join( "couldn't", split("couldnt", $str) );
	$str = join( "shouldn't", split("shouldnt", $str) );
	$str = join( "won't", split("wont", $str) );

	#remove apostraphies
	if(index($str, "n't") != -1){
		$str = join( " not", split("n't", $str) );
	}
	if(index($str, "'ve") != -1){
		$str = join( " have", split("'ve", $str) );
	}
	if(index($str, "'s") != -1){
		$str = join( " is", split("'s", $str) );
	}

	return $str;

}

1;