my $x = <>;

my @y = ($x =~ /mul\(\d*,\d*\)|do\(\)|don't\(\)/g);

my $sum = 0;

my $d = 1;

foreach (@y) {
  # print "$_\n";
  if ($_ =~ /do\(\)/) {
    $d = 1;
  } elsif ($_ =~ /don't\(\)/) {
    $d = 0;
  } elsif ($d == 1){
    my ($first, $second) = ($_ =~ /(\d*),(\d*)/g);
    # print "$first * $second\n";
    $sum = $sum + $first * $second;
  }
}

print $sum;
