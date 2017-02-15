use strict;
use warnings;
use 5.22.2;
use List::Util 'shuffle';


# Read the contents of /usr/share/dict/words and store the words to memory in the $dictionary variable 
my $file = '/usr/share/dict/words';
#my $fileSlurp = slurp($file);
#my $dictionary = quotemeta($fileSlurp);
my @vowels = ('a', 'e', 'i', 'o', 'u');


open (FH, "< $file") or die "Can't open $file for read: $!";
my @dictionary;
while (<FH>) {
    push (@dictionary, $_);
}
close FH or die "Cannot close $file: $!";

# sub slurp {
#   my $file = shift;
#   open my $fh, '<', $file or die;
#   local $/ = undef;
#   my $cont = <$fh>;
#   close $fh;
#   return $cont;
# }

# Generate words with vowel mistakes
sub misplaceVowels {
  my @misplacedVowelWords = ();
  my $word = shift;

  my $vowelReplacer = sub {
    my $letter = shift;
    my $index = shift;
    
    foreach my $vowel (@vowels) {
      my $wordCandidate = $word;
      substr($wordCandidate, $index, 1, $vowel) unless $letter eq $vowel; 
      push @misplacedVowelWords, $wordCandidate;
    }
    return $letter;
  };
  $word =~ s/(a|e|i|o|u)/$vowelReplacer->($1, $-[0])/eg;
  return @misplacedVowelWords;
}

my @shuffledDictionary = shuffle(@dictionary);
my $randomWord = $shuffledDictionary[0];
my @randomMispelledWords = misplaceVowels($randomWord);
@randomMispelledWords = shuffle(@randomMispelledWords);
my $randomMispelledWord = $randomMispelledWords[0];
print "$randomWord\n";
print "$randomMispelledWord\n";

