my $x = <>;

my @y = ($x =~ /mul\(\d*,\d*\)/g);

my $sum = 0;

foreach (@y) {
  my ($first, $second) = ($_ =~ /(\d*),(\d*)/g);
  print "$first * $second\n";
  $sum = $sum + $first * $second;
}

print $sum;
