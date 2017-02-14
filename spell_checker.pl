use strict;
use warnings;
use 5.22.2;
use Data::Dumper qw(Dumper);

# Read the contents of /usr/share/dict/words and store the words to memory in the $dictionary variable 
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

# Function which searches words for vowels and replaces each of
# them with other vowels and stores these strings in an array
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

# A loop to take the user input and run it through each spell check case 
# and generate possible words to check against the dictionary then output
# a possible correctin word to the user 
while (1) {
  print "> ";
  my $userWord = <STDIN>;
  chomp($userWord);
  my $lcUserWord = lc $userWord;
  my $repeatsRemoved = $lcUserWord;
  $repeatsRemoved =~ s/(.)\1+/$1/gi;

  #Case to handle words that are spelled correctly
  if($dictionary =~ /$userWord/) {
    print "NO SUGGESTIONS\n";
    next;
  }

  # Case to handle words with uppercasing spelling errors
  if($dictionary =~ /$lcUserWord/) {
    print "$lcUserWord\n"; 
    next;
  }

  # Case to handle repeating characters
  if ($dictionary =~ /$repeatsRemoved/) {
    print "$repeatsRemoved\n";
    next;
  }
  
  # Case to handle incorrect vowels
  if ($repeatsRemoved ne "") {
    my @vowelReplacementCandidates = replaceVowels($repeatsRemoved);
    my $vowelReplacementCandidate = "found word";
    
    foreach $vowelReplacementCandidate (@vowelReplacementCandidates) {
      if($dictionary =~ $vowelReplacementCandidate) {
        $repeatsRemoved = "found word";
        print "$vowelReplacementCandidate\n";
        last;  
      }
      else {
        my @moreCandidates = replaceVowels($vowelReplacementCandidate);
        foreach my $moreCandidate (@moreCandidates) {
          if($dictionary =~ $moreCandidate) {
            $repeatsRemoved = "found word";
            print "$moreCandidate\n";
            last;
          } 
        }
        #print @moreCandidates;
      }
      if ($repeatsRemoved eq "found word") {
        last;
      }
    }
    # Case to handle no suggestions 
    if ($vowelReplacementCandidate ne $repeatsRemoved) {
      print "NO SUGGESTIONS\n";
    } 
  }      
}