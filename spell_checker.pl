use strict;
use warnings;
use 5.22.2;
use Data::Dumper qw(Dumper);

# Read the contents of /usr/share/dict/words and store the words in the dictionary variable 
my $file = '/usr/share/dict/words';
my $fileSlurp = slurp($file);
my $dictionary = quotemeta($fileSlurp);
my @vowels = ('a', 'e', 'i', 'o', 'u');

sub slurp {
    my $file = shift;
    open my $fh, '<', $file or die;
    local $/ = undef;
    my $cont = <$fh>;
    close $fh;
    return $cont;
}

sub replaceVowels {
  my @vowelReplacements = ();
  my $word = shift;

  my $vowelReplacer = sub {
    my $letter = shift;
    my $index = shift;
    
    foreach my $vowel (@vowels) {
      my $wordCandidate = $word;
      substr($wordCandidate, $index, 1, $vowel) unless $letter eq $vowel; 
      push @vowelReplacements, $wordCandidate;
    }
    return $letter;
  };
  $word =~ s/(a|e|i|o|u)/$vowelReplacer->($1, $-[0])/eg;
  return @vowelReplacements;
}  



while (1) {
  print "> ";
  my $userWord = <STDIN>;
  chomp($userWord);
  my $lcUserWord = lc $userWord;
  my @vowelReplacementList = replaceVowels($userWord); 

  # Case to handle words that are spelled correctly
  print "Your spelling is correct!\n" if($dictionary =~ /$userWord/); 
  # Case to handle words with uppercasing spelling errors
  print "$lcUserWord\n" if($dictionary =~ $lcUserWord);
  print replaceVowels("$userWord\n");

}